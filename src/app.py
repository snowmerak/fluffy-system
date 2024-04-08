from git import Repo

repo = Repo('.')


last_tag = repo.tags[-1]

# commits from last tag
commits = list(repo.iter_commits(rev=last_tag.commit))
for commit in commits:
    print(commit.hexsha, commit.message.strip(), commit.author.name)


