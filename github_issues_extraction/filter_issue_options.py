import json
import re
import os

"""
    This script extracts all the Z3, CVC5 and Yices2 "(set-options :...)" keywords and their surrounding code 
    from issues previously extracted from the Z3 issue tracker and stores them in SMT2 files.
"""


ISSUES_FOLDER = 'extracted_issues'
OUTPUT_DIR = 'smt2_files'
OPTIONS_FOLDER = 'used_options'

# Patterns for identifying different parts of SMT2 code blocks
option_pattern = re.compile(r'\(set-option\s*:[^\)]+\)', re.IGNORECASE)
fenced_code_pattern = re.compile(r'^\s*```', re.IGNORECASE)
open_bracket_next_line = re.compile(r'^\s*\(.*', re.IGNORECASE)
check_sat_pattern = re.compile(r'^\(check-sat', re.IGNORECASE)
valid_code_line = re.compile(r'^[\(\)\:\;].*', re.IGNORECASE)
get_model_pattern = re.compile(r'^\s*\(get-model\)\s*$', re.IGNORECASE)
get_proof_pattern = re.compile(r'^\s*\(get-proof\)\s*$', re.IGNORECASE)
get_info_pattern = re.compile(r'^\s*\(get-info\s*:reason-unknown\)\s*$', re.IGNORECASE)

def extract_code_blocks(body, file_path = ''):

    """
    Extract code blocks that start with ``` and have an open bracket in the next line.
    Ends when (check-sat), (get-model), (get-proof) or (get-info: reason-unknown) is found, 
    and only allows lines with (, ), :, ; in between.
    """

    lines = body.splitlines()
    code_blocks = []
    inside_code_block = False
    current_block = []

    i = 0
    while i < len(lines):
        line = lines[i].strip()
        # Detect start of a code block
        if fenced_code_pattern.match(line) and (i + 1 < len(lines) and open_bracket_next_line.match(lines[i + 1].strip())):
            inside_code_block = True
            current_block.append(lines[i + 1].strip())
            i += 2
            continue
        # Collect all the lines until (check-sat) is found
        if inside_code_block:
            if check_sat_pattern.match(line):
                current_block.append(line)
                i += 1
                while i < len(lines):
                    next_line = lines[i].strip()
                    if get_model_pattern.match(next_line) or get_proof_pattern.match(next_line) or get_info_pattern.match(next_line):
                        current_block.append(next_line)
                        i += 1
                    else:
                        break
                code_blocks.append("\n".join(current_block))
                inside_code_block = False
                current_block = []
                continue
            elif valid_code_line.match(line) or line == "":
                current_block.append(line)
            else:
                # If line does not fit SMT2 pattern, we will remove this block
                print(f'Here: {line}')
                inside_code_block = False
                current_block = []
        i += 1

    return code_blocks

def options_from_json(file_path):

    """
    Extract code blocks and all options that occured in these code block from the
    solver issues (z3, cvc5 and yices2), that were previously extracted using the 
    Github API.
    """

    with open(file_path, 'r') as file:
        issues = json.load(file)
    
    unique_set_options = set()
    issues_without_set_option = []
    issue_code_blocks = {}

    for issue in issues:
        body = issue.get('body', '')
        if body == None:
            continue
        matches = option_pattern.findall(body.lower())
        
        if matches:
            unique_set_options.update(matches)
            # Extract the valid code blocks
            code_blocks = extract_code_blocks(body, file_path)
            if code_blocks:
                issue_code_blocks[issue.get('url')] = code_blocks
        else:
            issues_without_set_option.append(issue.get('url'))

    return unique_set_options, issues_without_set_option, issue_code_blocks

def store_code_blocks(issue_code_blocks, output_folder):

    """
    Store each code block from an issue in a separate SMT2 file.
    The filename will be based on the issue URL or a unique identifier.
    """

    for issue_url, code_blocks in issue_code_blocks.items():
        issue_id = issue_url.split('/')[-1]
        for i, code_block in enumerate(code_blocks):
            if code_block.strip():
                filename = os.path.join(output_folder, f"issue_{issue_id}_block_{i+1}.smt2")
                with open(filename, 'w') as smt_file:
                    smt_file.write(code_block)

def determine_unused_issues(issues):
    if issues:
        print("Issues without (set-option) statements:")
        for issue_url in issues:
            print(issue_url)
    else:
        print("All issues contain (set-option) statements.")


if __name__ == "__main__":
    out_dir = os.path.join(os.path.dirname(__file__), OUTPUT_DIR)
    os.makedirs(out_dir, exist_ok=True)
    out_options_path = os.path.join(os.path.dirname(__file__), OPTIONS_FOLDER)
    os.makedirs(out_options_path, exist_ok=True)

    for solver in ['z3', 'cvc5', 'yices2']:
        folder_path = os.path.join(out_dir, f'issues_{solver}')
        os.makedirs(folder_path, exist_ok=True)

        json_file_path = os.path.join(os.path.dirname(__file__), ISSUES_FOLDER, f'issues_{solver}.json')
        unique_set_options, issues_without_set_option, issue_code_blocks = options_from_json(json_file_path)

        out_options_file = os.path.join(out_options_path, f'options_from_{solver}_issues.txt')
        with open(out_options_file, 'w') as file:
            for option in unique_set_options:
                file.write(f"{option}\n")

        # Store the extracted code blocks in separate SMT2 files
        store_code_blocks(issue_code_blocks, folder_path)

        # Report issues that don't contain any (set-option) and 
        # were thus not used to extract a code block
        determine_unused_issues(issues_without_set_option)