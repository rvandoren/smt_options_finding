import os
from multiprocessing import Pool
from tqdm import tqdm
from smt2_handler import collect_smt_files, process_smt_file
from csv_handler import initialize_csv, combine_csv_files
from option_combinations import generate_random_option_combinations


"""
    For all the given folders containing the SMT files: Process SMT file corresponding to given 
    file path, checks its expected output and runs Z3 twice: once without options and once with 
    custom options (only if file has UNSAT expected output).
"""

COMBINATIONS = 4

# Path to the root folder containing SMT files
root_smt_folder = "Dataset"
# Path to folder that contains the SMT files that were used for the dataset
final_dataset = "final_dataset"
# CSV file containg the SMT filename, expected result, and achieved result
output_csv = "benchmarks_z3.csv"

# Z3 timeout time
timeout = 600

# Choose between "default" (does not remove existing options from the smt files)
# and "remove_existing" (removes the existing options before adding the custom
# options)
remove_existing = True

evaluate_model = True


def process_file_with_options(file, csv_filename):
    custom_options_list = generate_random_option_combinations(num_combinations=COMBINATIONS)
    process_smt_file(file, custom_options_list, root_smt_folder, final_dataset, csv_filename, timeout, remove_existing, evaluate_model)

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

    initialize_csv(csv_filename)
    for smt_file in smt_files_chunk:
        process_file_with_options(smt_file, csv_filename)

if __name__ == "__main__":
    os.makedirs(final_dataset, exist_ok=True)
    smt_files = collect_smt_files(root_smt_folder) #, "ChosenDataset", 20)
    print("done choosing smt files")
    parallel_process(smt_files, num_processes=4)