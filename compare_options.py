import os
import re

def extract_options(file_path):
    options = {}
    with open(file_path, 'r') as file:
        for line in file:
            match = re.match(r'\(set-option\s+([^\s]+)\s+(.*)\)', line)
            if match:
                option_name = match.group(1)
                option_value = match.group(2).strip()
                options[option_name] = option_value
    return options

def find_smt_files(folder):
    smt_files = []
    for root, dirs, files in os.walk(folder):
        for file in files:
            if file.endswith(".smt2"):
                smt_files.append(os.path.join(root, file))
    return smt_files

def compare_options(reference_options, file_options):
    differences = {}
    for option in reference_options:
        if option not in file_options:
            differences[option] = ("missing", reference_options[option])
        elif file_options[option] != reference_options[option]:
            differences[option] = ("different", reference_options[option], file_options[option])
    for option in file_options:
        if option not in reference_options:
            differences[option] = ("extra", file_options[option])
    
    return differences

def compare_files(smt_files):
    if not smt_files:
        print("No SMT files found.")
        return
    
    reference_file = smt_files[0]
    reference_options = extract_options(reference_file)
    print(f"Original file: {reference_file}")
    
    inconsistent_files = []
    
    for smt_file in smt_files[1:]:
        options = extract_options(smt_file)
        differences = compare_options(reference_options, options)
        
        if differences:
            inconsistent_files.append((smt_file, differences))
    
    if inconsistent_files:
        print("Inconsistencies:")
        for file, diffs in inconsistent_files:
            print(f"\nFile: {file}")
            for option, diff in diffs.items():
                if diff[0] == "missing":
                    print(f"Missing option {option} (expected: {diff[1]})")
                elif diff[0] == "extra":
                    print(f"Extra option {option} with value {diff[1]}")
                elif diff[0] == "different":
                    print(f"Option {option}: Original: {diff[1]}, New: {diff[2]}")
    else:
        print("All files have consistent options.")

def main(folder):
    smt_files = find_smt_files(folder)
    compare_files(smt_files)

folder_to_check = "viper_benchmarks"
main(folder_to_check)
