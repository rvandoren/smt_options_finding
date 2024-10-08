import os
from multiprocessing import Pool
from tqdm import tqdm
from smt2_handler import collect_smt_files, process_smt_file
from csv_handler import initialize_csv, combine_csv_files

"""
    For all the given folders containing the SMT files: Process SMT file corresponding to given 
    file path, checks its expected output and runs Z3 twice: once without options and once with 
    custom options (only if file has UNSAT expected output).
"""

# Path to the root folder containing SMT files
# root_smt_folder = "non-incremental"
root_smt_folder = "Dataset"
# Path to folder that contains the extracted SMT files where the expected output is UNSAT
unsat_sat_files = "small_dataset"
# CSV file containg the SMT filename, expected result, and achieved result
output_csv = "benchmarks_comparison.csv"

# Z3 timeout time
timeout = 600

# Choose between "default" (does not remove existing options from the smt files)
# and "remove_existing" (removes the existing options before adding the custom
# options)
mode = "remove_existing"

# Custom options
custom_options_1 = [
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

custom_options_2 = [
    "(set-option :smt.arith.solver 4)"
    "(set-option :smt.phase_selection 5)"
    "(set-option :rewriter.eq2ineq true)"
]

custom_options_3 = [
    "(set-option :rewriter.arith_ineq_lhs true)"
    "(set-option :rewriter.hoist_cmul true)"
    "(set-option :model_evaluator.array_equalities false)"
]

custom_options_list = [custom_options_1, custom_options_2, custom_options_3]

def process_file_with_options(file, csv_filename):
    process_smt_file(file, custom_options_list, root_smt_folder, unsat_sat_files, csv_filename, timeout, mode)

def parallel_process(smt_files, num_processes):

    """
    Distribute the smt_files among the processes and run them in parallel.
    Each process writes to its own CSV file.
    """

    chunks = [smt_files[i::num_processes] for i in range(num_processes)]
    csv_filenames = [f"process_results_{i}.csv" for i in range(num_processes)]
    with Pool(processes=num_processes) as pool:
        list(tqdm(pool.imap(process_chunk_with_filename, zip(chunks, csv_filenames)), total=len(smt_files), desc="Processing SMT files"))
    combine_csv_files(csv_filenames, output_csv)

def process_chunk_with_filename(args):

    """
    Unpack the arguments for each process when using imap.
    """

    smt_files_chunk, csv_filename = args
    process_chunk(smt_files_chunk, csv_filename)

def process_chunk(smt_files_chunk, csv_filename):

    """
    Process a chunk of SMT files and write the results to a single CSV file.
    """

    initialize_csv(csv_filename, num_custom_runs=2)
    for smt_file in smt_files_chunk:
        process_file_with_options(smt_file, csv_filename)

if __name__ == "__main__":
    os.makedirs(unsat_sat_files, exist_ok=True)
    # Collect all SMT files that have to be tested from a hierarchical folder structure
    smt_files = collect_smt_files(root_smt_folder) #, "ChosenDataset", 20)
    print("done choosing smt files")
    parallel_process(smt_files, num_processes=2)