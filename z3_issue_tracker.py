from github import Github
import json
from datetime import datetime, timedelta, timezone

"""
    Using the GitHub API: Extract all the information from all the user issues in the Z3 issue tracker
    that mention one of the defined keywords.
"""

TOKEN = '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'
REPOSITORY = 'Z3Prover/z3'

g = Github(TOKEN)
repo = g.get_repo(REPOSITORY)


KEYWORDS = ['option', 'options']#, 'tactic', 'tactics']
START_DATE = datetime(2024, 9, 29, tzinfo=timezone.utc)
END_DATE = START_DATE - timedelta(weeks=300)

def fetch_issues():

    # Fetch issues
    issues = repo.get_issues(state='all', since=END_DATE) #open and closed
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

def store_issues(issues):
    with open('filtered_issues.json', 'w') as file:
        json.dump(issues, file, indent=4)
    print(f'Stored {len(issues)} issues.')

issues = fetch_issues()
store_issues(issues)
