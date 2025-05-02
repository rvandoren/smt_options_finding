import csv
import os
from option_combinations import *


def append_results_to_csv(smt_path, theory, output_csv, expected_outputs, custom_options_list, default_results, custom_results):

    """
    Appends the results of a single SMT file processing to the CSV file.
    For incremental SMT files, writes one row for each result.
    - item: default_results = (verification result, time, model coverage)
    - item: custom_results = results for each custom option combination (Array of triples)
    """

    custom_encoded_features = encode_options_as_arrays(custom_options_list)
    default_encoded_features = encode_default_options_as_array()

    with open(output_csv, 'a', newline='') as csvfile:
        csv_writer = csv.writer(csvfile)


        if (len(expected_outputs) != len(default_results[0])) and (len(expected_outputs) != len(default_results[2])):
            print(f"Problem in file: {smt_path} processed by process {os.getpid()} for option combintation 'Default'")
            print(f"Expected results: {len(expected_outputs)}")
            print(f"Generated results: {len(default_results[0])}")
            print(f"Number of runtime analysis: {len(default_results[1])}")
            print(f"Number of model coverages: {len(default_results[2])}")
            row = ["Default", smt_path, theory] + default_encoded_features
            row.extend(["error", "error", "error", "error"])
            csv_writer.writerow(row)
        else:
            veriResults = default_results[0]
            totTime = default_results[1]
            modelCoverage = default_results[2]
            for idx, expected_output in enumerate(veriResults):
                actual_output_default = veriResults[idx]
                model_percentage_default = modelCoverage[idx]
                row = ["Default", smt_path, theory] + default_encoded_features + [expected_output, actual_output_default, totTime, model_percentage_default]
                csv_writer.writerow(row)

            
        for options_configuration_idx, results in enumerate(custom_results):
            if (len(expected_outputs) != len(results[0])) and (len(expected_outputs) != len(results[2])):
                print(f"Problem in file: {smt_path} processed by process {os.getpid()} for option combintation 'Custom {options_configuration_idx}'")
                print(f"Expected results: {len(expected_outputs)}")
                print(f"Generated results: {len(results[0])}")
                print(f"Number of runtime analysis: {len(results[1])}")
                print(f"Number of model coverages: {len(results[2])}")
                row = ["Custom {options_configuration_idx}", smt_path, theory] + custom_encoded_features[options_configuration_idx]
                row.extend(["error", "error", "error", "error"])
                csv_writer.writerow(row)
            else:
                veriResults = results[0]
                totTime = results[1]
                modelCoverage = results[2]
                for idx, expected_output in enumerate(veriResults):
                    actual_output_default = veriResults[idx]
                    model_percentage_default = modelCoverage[idx]
                    row = ["Custom {options_configuration_idx}", smt_path, theory] + custom_encoded_features[options_configuration_idx] + [expected_output, actual_output_default, totTime, model_percentage_default]
                    csv_writer.writerow(row)


def initialize_csv(output_csv):

    """
    Initializes the CSV file with headers.
    """

    with open(output_csv, 'w', newline='') as csvfile:
        csv_writer = csv.writer(csvfile)
        headers = ["Option Combination", "File Name", "Theory"]
        for opt_name in list(options.keys()):
            headers.append(opt_name)
        headers.extend(["Expected Result", "Verification Result", "Time Taken", "Model Coverage"])
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