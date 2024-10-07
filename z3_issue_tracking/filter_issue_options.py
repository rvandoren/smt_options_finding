import json
import re
import os

"""
    This script extracts all the Z3 "(set-options :...)" keywords and their surrounding code 
    from issues previously extracted from the Z3 issue tracker and stores them in SMT2 files.
"""


FILE = 'filtered_issues.json'
option_pattern = re.compile(r'\(set-option\s*:[^\)]+\)')

# Directory to store the SMT2 files
OUTPUT_DIR = 'smt2_files'
os.makedirs(OUTPUT_DIR, exist_ok=True)

# Patterns for identifying start and end of SMT2 code blocks
fenced_code_start = re.compile(r'^\s*```')
open_bracket_next_line = re.compile(r'^\s*\(.*')
check_sat_pattern = re.compile(r'^\s*\(check-sat\)\s*$')
valid_code_line = re.compile(r'^[\(\)\:\;].*')

def extract_code_blocks(body):
    """
    Extract code blocks that start with ``` and have an open bracket in the next line.
    Ends when (check-sat) is found, and only allows lines with (, ), :, ; in between.
    """
    lines = body.splitlines()
    code_blocks = []
    inside_code_block = False
    current_block = []

    # Patterns for additional commands after (check-sat)
    get_model_pattern = re.compile(r'^\s*\(get-model\)\s*$')
    get_proof_pattern = re.compile(r'^\s*\(get-proof\)\s*$')
    get_info_pattern = re.compile(r'^\s*\(get-info\s*:reason-unknown\)\s*$')


    i = 0
    while i < len(lines):
        line = lines[i].strip()

        # Detect start of a fenced code block
        if fenced_code_start.match(line) and (i + 1 < len(lines) and open_bracket_next_line.match(lines[i + 1].strip())):
            inside_code_block = True
            current_block.append(lines[i + 1].strip())  # Add the opening line (line after ```)
            i += 2  # Skip to the line after the opening parenthesis
            continue

        # Inside a code block, collect lines until (check-sat) is found
        if inside_code_block:
            if check_sat_pattern.match(line):
                current_block.append(line)
                i += 1
                # Check for valid lines right after (check-sat)
                while i < len(lines):
                    next_line = lines[i].strip()
                    if get_model_pattern.match(next_line) or get_proof_pattern.match(next_line) or get_info_pattern.match(next_line):
                        current_block.append(next_line)
                        i += 1
                    else:
                        break
                code_blocks.append("\n".join(current_block))  # Save the completed code block
                inside_code_block = False
                current_block = []
                continue
            elif valid_code_line.match(line):
                current_block.append(line)  # Collect valid lines
            else:
                # If any line doesn't match the valid SMT2 line pattern, abandon this block
                inside_code_block = False
                current_block = []

        i += 1

    return code_blocks

def options_from_json(file_path):
    with open(file_path, 'r') as file:
        issues = json.load(file)
    
    unique_set_options = set()
    issues_without_set_option = []
    issue_code_blocks = {}

    for issue in issues:
        body = issue.get('body', '')
        if body == None:
            continue
        body = body.lower()
        matches = option_pattern.findall(body)
        
        if matches:
            unique_set_options.update(matches)
            # Extract the valid code blocks
            code_blocks = extract_code_blocks(body)
            if code_blocks:
                issue_code_blocks[issue.get('url')] = code_blocks
        else:
            issues_without_set_option.append(issue.get('url'))

    return unique_set_options, issues_without_set_option, issue_code_blocks

def store_options(set_options):
    with open('options_from_issues.txt', 'w') as file:
        for option in set_options:
            file.write(f"{option}\n")

def store_code_blocks(issue_code_blocks):
    """
    Store each code block from an issue in a separate SMT2 file.
    The filename will be based on the issue URL or a unique identifier.
    """
    for issue_url, code_blocks in issue_code_blocks.items():
        # Use the issue ID or URL as part of the filename
        issue_id = issue_url.split('/')[-1]  # Extract the issue number from the URL
        
        for i, code_block in enumerate(code_blocks):
            if code_block.strip():  # Only write if the block contains non-empty content
                filename = os.path.join(OUTPUT_DIR, f"issue_{issue_id}_block_{i+1}.smt2")
                with open(filename, 'w') as smt_file:
                    smt_file.write(code_block)
                print(f"Stored code block in {filename}")

def report_issues_without_set_options(issues):
    if issues:
        print("Issues without (set-option) statements:")
        for issue_url in issues:
            print(issue_url)
    else:
        print("All issues contain (set-option) statements.")

# Process the issues from the JSON file
unique_set_options, issues_without_set_option, issue_code_blocks = options_from_json(FILE)

# Store the unique (set-option) options in a file
store_options(unique_set_options)

# Store the extracted code blocks in separate SMT2 files
store_code_blocks(issue_code_blocks)

# Report issues that don't contain any (set-option)
report_issues_without_set_options(issues_without_set_option)