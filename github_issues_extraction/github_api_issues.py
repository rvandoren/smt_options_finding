from github import Github
import json
import os
from datetime import datetime, timedelta, timezone

"""
    Using the GitHub API: Extract all the information from all the user issues in the Z3, CVC5 or Yices2 issue tracker
    that mention one of the defined keywords.
"""

# Adjust to personal access token
PERSONAL_ACCESS_TOKEN = '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'
# REPOSITORY = 'Z3Prover/z3'  # 100 weeks
# REPOSITORY = 'cvc5/cvc5'  # 100 weeks
REPOSITORY = 'SRI-CSL/yices2'  # 300 weeks

g = Github(PERSONAL_ACCESS_TOKEN)
repo = g.get_repo(REPOSITORY)

KEYWORDS = ['option', 'options']#, 'tactic', 'tactics']
START_DATE = datetime(2024, 10, 1, tzinfo=timezone.utc)
END_DATE = START_DATE - timedelta(weeks=300)

def fetch_issues():

    # Fetch issues
    issues = repo.get_issues(state='all', since=END_DATE) # open and closed issues
    filtered_issues = []

    # Search for keywords
    for issue in issues:
        created_at = issue.created_at
        if created_at > START_DATE:
            continue
        title = issue.title.lower()
        body = issue.body.lower() if issue.body else ''
        if any(keyword.lower() in title or keyword.lower() in body for keyword in KEYWORDS):
            filtered_issues.append({
                'title': issue.title,
                'url': issue.html_url,
                'state': issue.state,
                'created_at': str(issue.created_at),
                'body': issue.body,
                'comments': issue.comments
            })
    return filtered_issues

def store_issues(issues, repo_name, folder_path = 'extracted_issues/'):
    folder_path = os.path.join(os.path.dirname(__file__), folder_path)
    os.makedirs(folder_path, exist_ok=True)
    file_path = os.path.join(folder_path, f'issues_{repo_name}.json')
    with open(file_path, 'w') as file:
        json.dump(issues, file, indent=4)
    print(f'Stored {len(issues)} issues from the {repo_name} Github repository in {file_path}.')

if __name__ == "__main__":
    issues = fetch_issues()
    if REPOSITORY == 'Z3Prover/z3':
        repo_name = 'z3'
    elif REPOSITORY == 'cvc5/cvc5':
        repo_name = 'cvc5'
    elif REPOSITORY == 'SRI-CSL/yices2':
        repo_name = 'yices2'
    else:
        repo_name = ''
    store_issues(issues, repo_name)