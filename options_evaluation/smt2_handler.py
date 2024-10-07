import os
import shutil
import random
from runner import run_z3
from csv_handler import append_to_csv

def collect_smt_files(root_folder):

    """
    Collects 20 random SMT file paths from each first-level folder in the root folder.
    """

    smt_files = []
    for first_level_folder in os.listdir(root_folder):
        first_level_path = os.path.join(root_folder, first_level_folder)
        if os.path.isdir(first_level_path):
            folder_files = []
            for root, _, files in os.walk(first_level_path):
                for file in files:
                    if file.endswith('.smt2'):
                        folder_files.append(os.path.join(root, file))
                selected_files = random.sample(folder_files, min(20, len(folder_files)))
                smt_files.extend(selected_files)
                break
    return smt_files


def process_smt_file(smt_path, custom_options_list, root_smt_folder, unsat_files, output_csv, timeout, mode):

    """
    Process an individual SMT file and run Z3 multiple times.
    """

    with open(smt_path, 'r') as file:
        lines = file.readlines()
    existing_options, new_lines, expected_outputs = extract_options_and_output(lines)
    if not expected_outputs:
        expected_outputs = ["None"]
    # Check if expected output is UNSAT or SAT
    elif not ("unsat" in expected_outputs or "sat" in expected_outputs):
        return
    # Store existing options in csv
    options = "; ".join(existing_options) if existing_options else "None"
    # Copy the file to the folder containing all UNSAT and SAT SMT formulas
    copy_unsat_file(smt_path, unsat_files, root_smt_folder)

    # Run Z3 with default options
    modified_smt_path = modify_smt_file(smt_path, lines, new_lines, [], mode)
    actual_outputs_default, total_time_default = run_z3(smt_path, timeout)
    os.remove(modified_smt_path)
    
    # Run Z3 with each set of custom options
    custom_results = []
    for custom_options in custom_options_list:
        # Modify SMT file temporarily by adding custom options and
        # with or without removing existing options
        modified_smt_path = modify_smt_file(smt_path, lines, new_lines, custom_options, mode)
        actual_outputs_custom, total_time_custom = run_z3(modified_smt_path, timeout)
        os.remove(modified_smt_path)
        custom_results.append((actual_outputs_custom, total_time_custom))
    # Append results to CSV
    for i, expected_output in enumerate(expected_outputs):
        append_to_csv(smt_path, output_csv, expected_output, options, actual_outputs_default, total_time_default, custom_results)


def extract_options_and_output(lines):

    """
    Extracts existing SMT options and expected output from the file lines.
    """

    existing_options = []
    new_lines = []
    expected_outputs = []
    for line in lines:
        if line.startswith("(set-info :status "):
            expected_output = line.split(":status")[-1].strip().replace(")", "")
            expected_outputs.append(expected_output)
        elif line.startswith("(set-option :"):
            existing_options.append(line.strip())
        else:
            new_lines.append(line)
    return existing_options, new_lines, expected_output

def copy_unsat_file(smt_path, unsat_files, root_smt_folder):

    """
    Copies the file to the UNSAT files folder.
    """

    new_path = os.path.join(unsat_files, smt_path.replace(root_smt_folder, "").replace(os.sep, "_").lstrip("_"))
    os.makedirs(os.path.dirname(new_path), exist_ok=True)
    shutil.copy(smt_path, new_path)

def modify_smt_file(smt_path, lines, new_lines, custom_options, mode):

    """
    Modifies the SMT file by removing existing options if the mode is 'remove_existing'.
    """

    if mode == "remove_existing":
        modified_lines = custom_options + new_lines
    else:
        modified_lines = custom_options + lines
    modified_smt_path = smt_path + ".modified"
    with open(modified_smt_path, 'w') as modified_file:
        modified_file.writelines(modified_lines)
    return modified_smt_path
