import os
import re
from runner import run_z3, run_cvc5
from csv_handler import *
from utils import *


def process_smt_file(smt_path, custom_options_list, root_smt_folder, unsat_files, output_csv, timeout, remove_existing, evaluate_model):

    """
    Process an individual SMT file and run Z3 multiple times.
    """

    with open(smt_path, 'r') as file:
        lines = file.readlines()

    existing_options, new_lines, expected_outputs, theory, total_vars = extract_options_output_theory(lines)
    if not expected_outputs:
        expected_outputs = ["None"]
    elif not ("unsat" in expected_outputs or "sat" in expected_outputs or "unknown" in expected_outputs):
        return
    
    # Save all the options that were already defined in the SMT file
    options = "; ".join(existing_options) if existing_options else "None"

    # Copy the file to the folder containing all SMT formulas that were used to create the processed dataset
    copy_file(smt_path, unsat_files, root_smt_folder)

    # Run with default options
    modified_smt_path = modify_options_in_file(smt_path, lines, new_lines, [], remove_existing, evaluate_model)
    verification_results_default, total_time_default, model_assigned_percentages_default = run_z3(modified_smt_path, total_vars, timeout)
    try:
        os.remove(modified_smt_path)
    except FileNotFoundError:
        print(f"Warning: Could not remove the file {modified_smt_path} as it was not found.")

    # Run with each set of custom options
    custom_results = []
    for custom_options in custom_options_list:

        # Modify SMT file temporarily by adding custom options
        modified_smt_path = modify_options_in_file(smt_path, lines, new_lines, custom_options, remove_existing, evaluate_model)
        verification_results_custom, total_time_custom, model_assigned_percentages_custom = run_z3(modified_smt_path, total_vars, timeout)
        custom_results.append((verification_results_custom, total_time_custom, model_assigned_percentages_custom))
        try:
            os.remove(modified_smt_path)
        except FileNotFoundError:
            print(f"Warning: Could not remove the file {modified_smt_path} as it was not found.")

    append_results_to_csv(smt_path, theory, output_csv, expected_outputs, options, verification_results_default, total_time_default,  model_assigned_percentages_default, custom_results)


def extract_options_output_theory(lines):

    """
    Extracts existing SMT options and expected output from the file lines.
    """

    existing_options = []
    new_lines = []
    expected_outputs = []
    theory = None
    total_vars = 0

    for line in lines:
        if line.startswith("(set-info :status "):
            expected_output = line.split(":status")[-1].strip().replace(")", "")
            expected_outputs.append(expected_output)
        elif line.startswith("(set-option :"):
            existing_options.append(line.strip())
        elif line.startswith("(set-logic"):
            new_lines.append(line)
            start = line.find(" ") + 1
            end = line.find(")")
            if start > 0 and end > start:
                theory = line[start:end].strip()
        elif line.startswith("(declare-"):
            new_lines.append(line)
            total_vars += 1
        elif line.startswith("(define-"):
            new_lines.append(line)
            total_vars += 1
        else:
            new_lines.append(line)
    return existing_options, new_lines, expected_outputs, theory, total_vars


def add_get_model(lines):

    """
    Adds (get-model) after every (check-sat) statement in the SMT file.
    """
    
    updated_lines = ["(set-option :produce-models true)\n"]
    for line in lines:
        updated_lines.append(line)
        if line.strip() == "(check-sat)":
            updated_lines.append("(get-model)\n")
    return updated_lines


def modify_options_in_file(smt_path, lines, new_lines, custom_options, remove_existing, evaluate_model):

    """
    Modifies the SMT file by removing existing options if the mode is 'remove_existing'.
    """

    if remove_existing:
        modified_lines = custom_options + new_lines
    else:
        modified_lines = custom_options + lines
    
    if evaluate_model:
        modified_lines = add_get_model(modified_lines)

    modified_smt_path = smt_path + ".modified"
    with open(modified_smt_path, 'w') as modified_file:
        modified_file.writelines(modified_lines)
    return modified_smt_path