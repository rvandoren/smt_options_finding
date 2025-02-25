import csv
import os
from option_combinations import *


def append_results_to_csv(smt_path, theory, output_csv, expected_outputs, option_config, verification_results_default, total_time_default, model_assigned_percentages_default, custom_results):

    """
    Appends the results of a single SMT file processing to the CSV file.
    For incremental SMT files, writes one row for each result.
    """

    encoded_features = [encode_default_options_as_array()] +  encode_options_as_arrays(option_config)

    with open(output_csv, 'a', newline='') as csvfile:
        csv_writer = csv.writer(csvfile)

        if len(expected_outputs) != len(verification_results_default):

            print(f"Problem in file: {smt_path} processed by process {os.getpid()}")
            print(len(expected_outputs))
            print(len(verification_results_default))
            row = [smt_path, theory] + encoded_features[0]
            row.extend(["error", "error", "error", "error"])
            csv_writer.writerow(row)

        else: 

            for idx, expected_output in enumerate(expected_outputs):
                actual_output_default = verification_results_default[idx]
                if idx < len(model_assigned_percentages_default):
                    model_percentage_default = model_assigned_percentages_default[idx]
                else:
                    model_percentage_default = "NA"
                
                row = [smt_path, theory] + encoded_features[0] + [expected_output, actual_output_default, total_time_default, model_percentage_default]
                csv_writer.writerow(row)

            
        for idx_options, (verification_results_custom, total_time_custom, model_assigned_percentages_custom) in enumerate(custom_results):
            if len(expected_outputs) != len(verification_results_custom):

                print(f"Problem in file: {smt_path} processed by process {os.getpid()}")
                print(len(expected_outputs))
                print(len(verification_results_custom))
                row = [smt_path, theory] + encoded_features[idx_options + 1]
                row.extend(["error", "error", "error", "error"])
                csv_writer.writerow(row)

            else:

                for idx, expected_output in enumerate(expected_outputs):
                    actual_output_custom = verification_results_custom[idx]
                    if idx < len(model_assigned_percentages_custom):
                        model_percentage_custom = model_assigned_percentages_custom[idx]
                    else:
                        model_percentage_custom = "NA"
                    
                    row = [smt_path, theory] + encoded_features[idx_options + 1] + [expected_output, actual_output_custom, total_time_custom, model_percentage_custom]
                    csv_writer.writerow(row)


def initialize_csv(output_csv):

    """
    Initializes the CSV file with headers.
    """

    with open(output_csv, 'w', newline='') as csvfile:
        csv_writer = csv.writer(csvfile)
        headers = ["File Name"]
        for opt_name in list(options.keys()):
            headers.append(opt_name)
        headers.extend(["Expected Result", "Theory", "Verification Result", "Time Taken", "Model Coverage"])
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