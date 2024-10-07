import subprocess
import time

def run_z3(smt_path, timeout):
    """
    Runs Z3 on the given SMT file and returns the output and execution time.
    """
    
    start_time = time.time()
    try:
        result = subprocess.run(['z3', smt_path], capture_output=True, text=True, timeout=timeout)
        actual_output = result.stdout.strip()
    except subprocess.TimeoutExpired:
        actual_output = "timeout"
    end_time = time.time()
    total_time = round(end_time - start_time, 2)
    outputs = [out.strip() for out in actual_output.splitlines() if out.strip() in ['sat', 'unsat', 'unknown', 'timeout']]
    return outputs, total_time