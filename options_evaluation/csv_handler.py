import csv
import os


def append_to_csv(smt_path, output_csv, expected_output, options, actual_output_default, total_time_default, custom_results):

    
    """
    Appends the results of a single SMT file processing to the CSV file.
    """
    
    with open(output_csv, 'a', newline='') as csvfile:
        csv_writer = csv.writer(csvfile)
        
        # list to store all results 
        row = [smt_path, expected_output, actual_output_default, total_time_default]
        
        # Add each custom result
        for actual_output_custom, total_time_custom in custom_results:
            row.extend([actual_output_custom, total_time_custom])
        
        csv_writer.writerow(row)


def initialize_csv(output_csv, num_custom_runs):

    """
    Initializes the CSV file with headers.
    """

    with open(output_csv, 'w', newline='') as csvfile:
        csv_writer = csv.writer(csvfile)
        headers = ["File Name", "Expected Outcome", "Actual Outcome (Default)", "Time Taken (Default)"]
        for i in range(1, num_custom_runs + 1):
            headers.extend([f"Actual Outcome (Custom {i})", f"Time Taken (Custom {i})"])
        csv_writer.writerow(headers)


def combine_csv_files(csv_filenames, output_csv):

    """
    Combines individual process CSV files into a single CSV file.
    """

    with open(output_csv, 'w', newline='') as outfile:
        csv_writer = None
        for csv_filename in csv_filenames:
            with open(csv_filename, 'r') as infile:
                csv_reader = csv.reader(infile)
                if csv_writer is None:
                    csv_writer = csv.writer(outfile)
                    csv_writer.writerow(next(csv_reader))
                else:
                    next(csv_reader)
                for row in csv_reader:
                    csv_writer.writerow(row)
    for csv_filename in csv_filenames:
        os.remove(csv_filename)