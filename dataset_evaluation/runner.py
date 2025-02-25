import subprocess
import time
from smt2_handler import *
import re
from csv_handler import *
from utils import *
import datetime

def calculate_model_assigned_percentage(model_lines, total_vars):

    """
    Calculates the percentage of variables assigned a value in the model.
    """

    assigned_vars = 0
    for line in model_lines:
        if line.startswith("(define-"):
            assigned_vars += 1

    if not total_vars:
        return "NA"
    return (assigned_vars / total_vars) * 100.0

def run_z3(smt_path, total_vars, timeout):

    """
    Runs Z3 on the given SMT file and returns the output and execution time.
    """
    
    start_time = time.time()
    try:
        result = subprocess.run(['z3', smt_path], capture_output=True, text=True, timeout=timeout)
        actual_output = result.stdout.strip()
        error = result.stderr

        output_folder = "z3_logs"
        if not os.path.exists(output_folder):
            os.makedirs(output_folder)
        timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S_%f")
        file_name = f"log_{timestamp}.txt"
        file_path = os.path.join(output_folder, file_name)
        with open(file_path, 'w') as f:
            f.write(str(smt_path))
            f.write("Function Output:\n")
            f.write(str(actual_output))
            f.write("Function Error:\n")
            f.write(str(error))

    except subprocess.TimeoutExpired:
        return ["timeout"], timeout, []

    end_time = time.time()
    total_time = round(end_time - start_time, 2)

    verification_results = []
    model_assigned_percentages = []
    current_model = []
    current_output = None

    for line in actual_output.splitlines():
        stripped_line = line.strip()
        if stripped_line in ['sat', 'unsat', 'unknown', 'timeout']:
            current_output = stripped_line
            verification_results.append(stripped_line)
            if current_model:
                model_assigned_percentages.append(calculate_model_assigned_percentage(current_model, total_vars))
                current_model = []
            else: 
                model_assigned_percentages.append("NA")
        elif current_output in ['sat', 'unknown']:
            current_model.append(stripped_line)

    if current_model:
        model_assigned_percentages.append(calculate_model_assigned_percentage(current_model, total_vars))
    else:
        model_assigned_percentages.append("NA")

    if (len(verification_results) == 0) or (len(model_assigned_percentages) == 0):
        print(error)
    return verification_results, total_time, model_assigned_percentages


# CVC5 is not supported yet
def run_cvc5(smt_path, timeout):
    """
    Runs cvc5 on the given SMT file and returns the output and execution time.
    """
    
    start_time = time.time()
    try:
        result = subprocess.run(['cvc5', smt_path], capture_output=True, text=True, timeout=timeout)
        actual_output = result.stdout.strip()
        error = result.stderr
    except subprocess.TimeoutExpired:
        actual_output = "timeout"
    end_time = time.time()
    total_time = round(end_time - start_time, 2)
    outputs = [out.strip() for out in actual_output.splitlines() if out.strip() in ['sat', 'unsat', 'unknown', 'timeout']]
    if len(outputs) == 0:
        print(error)
    return outputs, total_time