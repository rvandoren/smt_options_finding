import os
import subprocess
import csv
import shutil
from tqdm import tqdm
import time
from multiprocessing import Pool, cpu_count

"""
    For all the given folders containing the SMT files: Process SMT file corresponding to given 
    file path, checks its expected output and runs Z3 twice: once without options and once with 
    custom options (only if file has UNSAT expected output).
"""

# Path to the root folder containing SMT files
root_smt_folder = "non-incremental"
# Path to folder that contains the extracted SMT files where the expected output is UNSAT
unsat_files = "LIA_LRA_UNSAT"
# CSV file containg the SMT filename, expected result, and achieved result
output_csv = "comparison.csv"

# Z3 timeout time
timeout = 420

# Custom options
custom_options = [
    # all names are global
    "(set-option :global-decls true)" # default: false, I don't if this affect the result
    # use heuristics to automatically select solver and configure it
    "(set-option :auto_config false)" # default: true
    # 0 - case split based on variable activity, 1 - similar to 0, but delay case splits created during the search
    "(set-option :smt.case_split 3)" # default: 1
    # if true then z3 will not restart when a unit clause is learned
    "(set-option :smt.delay_units true)" # default: false
    "(set-option :type_check true)" # default: true
    # model based quantifier instantiation
    "(set-option :smt.mbqi false)" # default: true
    # use Bit-Vector literals (e.g, #x0F and #b0101) during pretty printing
    "(set-option :pp.bv_literals false)" # default: true
    # threshold for eager quantifier instantiation
    "(set-option :smt.qi.eager_threshold 100)" # default: 10.0
    # arithmetic solver: 0 - no solver, 2: simplex based solver, 6: lra solver
    "(set-option :smt.arith.solver 2)" # default: 6
    "(set-option :model.v2 true)" # I don't if this affect the result
    # specify the number of extra multi patterns
    "(set-option :smt.qi.max_multi_patterns 1000)" # default: 0
]

os.makedirs(unsat_files, exist_ok=True)
with open(output_csv, 'w', newline='') as csvfile:
    csv_writer = csv.writer(csvfile)
    csv_writer.writerow(["File Name", "Expected Outcome", "Existing Options", "Actual Outcome (Default)", "Time Taken (Default)", "Actual Outcome (Custom)", "Time Taken (Custom)"])

def process_smt_file(smt_path):
    with open(smt_path, 'r') as file:
        lines = file.readlines()
    
    existing_options = []
    for line in lines:
        if line.startswith("(set-info :status "):
            expected_output = line.split(":status")[-1].strip().replace(")", "")
        elif line.startswith("(set-option :"):
            existing_options.append(line.strip())

    # Check if expected output is UNSAT
    if expected_output != "unsat":
        return

    # Store existing options in csv
    options = "; ".join(existing_options) if existing_options else "None"
        
    # Run Z3 with default options
    start_time = time.time()
    try:
        result = subprocess.run(['z3', smt_path], capture_output=True, text=True, timeout=timeout)
        actual_output_default = result.stdout.strip()
    except subprocess.TimeoutExpired:
        actual_output_default = "timeout"
    end_time = time.time()
    total_time_default = round(end_time - start_time, 2)

    # Copy the file folder containing all UNSAT SMT formulas
    new_path = os.path.join(unsat_files, smt_path.replace(root_smt_folder, "").replace(os.sep, "_").lstrip("_"))
    os.makedirs(os.path.dirname(new_path), exist_ok=True)
    shutil.copy(smt_path, new_path)

    # Modify SMT file temporarily by adding custom options
    custom_lines = custom_options + lines
    modified_smt_path = smt_path + ".modified"
    with open(modified_smt_path, 'w') as modified_file:
        modified_file.writelines(custom_lines)
    
    # Run Z3 with modified options
    start_time = time.time()
    try:
        result = subprocess.run(['z3', modified_smt_path], capture_output=True, text=True, timeout=timeout)
        actual_output_custom = result.stdout.strip()
    except subprocess.TimeoutExpired:
        actual_output_custom = "timeout"
    end_time = time.time()
    total_time_custom = round(end_time - start_time, 2)
    os.remove(modified_smt_path)

    # Write result to CSV file with default options
    with open(output_csv, 'a', newline='') as csvfile:
        csv_writer = csv.writer(csvfile)
        csv_writer.writerow([smt_path, expected_output, options, actual_output_default, total_time_default, actual_output_custom, total_time_custom])


# Collect all SMT file paths
smt_files = []
for root, _, files in os.walk(root_smt_folder):
    for file in files:
        if file.endswith('.smt2'):
            smt_files.append(os.path.join(root, file))

def parallel_process(files):
    with Pool(processes=10) as pool:
        list(tqdm(pool.imap(process_smt_file, files), total=len(files), desc="Processing SMT files"))


if __name__ == "__main__":
    parallel_process(smt_files)