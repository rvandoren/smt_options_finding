import subprocess
import os
import csv
import tqdm

def run_solver(command):

    """
    Run the SMT solver using the provided command and return the result.
    """

    try:
        result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=600)
        output = result.stdout.decode('utf-8').strip()
        print(output)
        if "unsat" in output:
            return "unsat"
        elif "sat" in output:
            return "sat"
        elif "unknown" in output:
            return "unknown"
        else:
            return "error"
    except subprocess.TimeoutExpired:
        return "timeout"
    except Exception as e:
        print(f"Error running solver: {str(e)}")
        return "error"

def get_majority_vote(votes):

    """
    Return the majority vote from the solvers.
    """

    result_counts = {"sat": 0, "unsat": 0, "unknown": 0, "error": 0}
    for vote in votes:
        if vote in result_counts:
            result_counts[vote] += 1
    
    majority = max(result_counts, key=result_counts.get)
    if result_counts[majority] > 1:
        return majority
    return "inconclusive"

def check_smt_file(filepath):

    """
    Check an SMT file using Z3, CVC5, and Yices2 and return the majority vote result.
    """

    z3_command = ['z3', filepath]
    cvc5_command = ['cvc5', filepath]
    yices2_command = ['yices-smt2', filepath]
    print("z3")
    z3_result = run_solver(z3_command)
    print("cvc5")
    cvc5_result = run_solver(cvc5_command)
    print("yices")
    yices2_result = run_solver(yices2_command)
    
    votes = [z3_result, cvc5_result, yices2_result]
    
    return get_majority_vote(votes), votes

def process_folder(folder_path, output_csv):

    """
    Process all SMT files in the folder and write the expected result to a CSV file.
    """
    
    with open(output_csv, mode='w', newline='') as csv_file:
        writer = csv.writer(csv_file)
        writer.writerow(['Filename', 'Expected Result', 'Z3 Result', 'CVC5 Result', 'Yices2 Result'])

        for root, dirs, files in os.walk(folder_path):
            for filename in files:
                if filename.endswith('.smt2'):
                    filepath = os.path.join(root, filename)
                    majority_vote, votes = check_smt_file(filepath)
                    writer.writerow([filename, majority_vote] + votes)

if __name__ == "__main__":
    folder_path = os.path.join(os.path.dirname(__file__), 'smt2_files/')
    os.makedirs(folder_path, exist_ok=True)
    output_path = os.path.join(os.path.dirname(__file__), 'expected_ouputs_issues.csv')
    process_folder(folder_path, output_path)
    print(f"Results written to {output_path}")
