import pandas as pd

### A file to filter the results from the processed Dataset.


df = pd.read_csv('benchmarks_z3.csv')
outcome_columns = ['Actual Outcome (Default)', 'Actual Outcome (Custom 1)', 'Actual Outcome (Custom 2)', 'Actual Outcome (Custom 3)', 'Actual Outcome (Custom 4)']
time_columns = ['Time Taken (Default)', 'Time Taken (Custom 1)', 'Time Taken (Custom 2)', 'Time Taken (Custom 3)', 'Time Taken (Custom 4)']


outcome_diff = df[outcome_columns].nunique(axis=1) > 1
time_diff = df[time_columns].apply(lambda row: max(row) - min(row), axis=1) > 10
filtered_df = df[outcome_diff | time_diff]

filtered_df.to_csv('filtered_output_z3.csv', index=False)