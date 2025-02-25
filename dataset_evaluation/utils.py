import os
import shutil
import random

def collect_smt_files(root_folder): #, chosen_smt_files, max_files_per_theory):

    # NOT DONE HERE: Collects 20 random SMT file paths from each first-level folder in the root folder.

    # os.makedirs(chosen_smt_files, exist_ok=True)
    # smt_files = []
    folder_files = []
    for first_level_folder in os.listdir(root_folder):
        first_level_path = os.path.join(root_folder, first_level_folder)
        if os.path.isdir(first_level_path):
            for root, _, files in os.walk(first_level_path, topdown=True):
                for file in files:
                    if file.endswith('.smt2'):
                        folder_files.append(os.path.join(root, file))
            # selected_files = random.sample(folder_files, min(20, len(folder_files)))
            # for smt_file in selected_files:
            #     relative_path = os.path.relpath(smt_file, root_folder)
            #     new_file_path = os.path.join(chosen_smt_files, relative_path)
            #     os.makedirs(os.path.dirname(new_file_path), exist_ok=True)
            #     shutil.copy(smt_file, new_file_path)
            # smt_files.extend(selected_files)
    return folder_files

def copy_file(smt_path, unsat_files, root_smt_folder):

    """
    Copies the file to the folder that saves all used files.
    """

    new_path = os.path.join(unsat_files, smt_path.replace(root_smt_folder, "").replace(os.sep, "_").lstrip("_"))
    os.makedirs(os.path.dirname(new_path), exist_ok=True)
    shutil.copy(smt_path, new_path)