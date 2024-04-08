import re
from git import Repo, TagReference

def commit_message_to_semver_vector(message: str) -> tuple[int, int, int]:
    prefix = message.split(': ')[0].strip().lower()
    print(prefix)
    match prefix:
        case 'feat':
            return (0, 1, 0)
        case 'break':
            return (1, 0, 0)
        case 'chore':
            return (0, 0, 1)
        case 'fix':
            return (0, 0, 1)
        case _:
            return (0, 0, 0)


def verify_semver(message: str) -> bool:
    return re.match(r'^\d+\.\d+\.\d+$', message) != None


def get_semver(message: TagReference) -> tuple[int, int, int]:
    if message == None:
        return (0, 0, 0)
    v = list(map(lambda x: int(x), message.strip().split('.')))
    if len(v) != 3:
        raise ValueError('Invalid semver format')
    t: tuple[int, int, int] = [0, 0, 0]
    for i in range(3):
        t[i] = v[i]
    return t


def get_last_tag(repo: Repo) -> TagReference:
    tags = repo.tags
    try:
        for tag in tags:
            if verify_semver(tag.name):
                return tag
    except IndexError:
        return None
    return None


def iter_commits(repo: Repo, last_tag: TagReference) -> tuple[int, int, int]:
    semver = [0, 0, 0]
    for commit in repo.iter_commits():
        if last_tag != None and commit == last_tag.commit:
            break
        vector = commit_message_to_semver_vector(commit.message.strip())
        semver[0] += vector[0]
        semver[1] += vector[1]
        semver[2] += vector[2]
    return semver


repo = Repo('.')

last_tag = get_last_tag(repo)
last_semver = get_semver(last_tag)
vector_semver = iter_commits(repo, last_tag)

semver: tuple[int, int, int] = (last_semver[0] + vector_semver[0], last_semver[1] + vector_semver[1], last_semver[2] + vector_semver[2])

print(f'{semver[0]}.{semver[1]}.{semver[2]}')

