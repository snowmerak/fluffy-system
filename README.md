# fluffy-system

This is a simple semver versioning system for your project. It is a simple way to manage your project versioning.

## Installation

```bash
docker pull snowmerak/fluffy
```

## Usage

```bash
cd /path/to/your/project

docker run --rm -v $(pwd):/workspace snowmerak/fluffy
```

### Commit Message Format

```
<type>: <description>
```

#### Type

- **feat**: A new feature
- **fix**: A typo or a bug fix
- **docs**: Documentation only changes
- **break**: A breaking change
- **chore**: Changes to the build process or auxiliary tools and libraries such as documentation generation
- **bug**: A bug fix

