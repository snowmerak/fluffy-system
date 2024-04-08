from git import Repo

repo = Repo('.')

last_tag = repo.tags.pop()

commits: list[str] = []
for commit in repo.iter_commits():
    if commit == last_tag.commit:
        break
    commits.append(commit.message.strip())

print(commits)

