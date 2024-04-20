latest_tag=$(git describe --tags $(git rev-list --tags --max-count=1))

IFS='.' read -r major minor patch <<< "$latest_tag"

last_commit_message="Merge branch 'feature/add_new_feature' into develop"
regex="Merge branch '(.+)' into"
if [[ "$last_commit_message" =~ $regex ]]; then
    branch_name="${BASH_REMATCH[1]}";
else
    echo "Error: Branch name not found in the last commit message."
    exit 1
fi

if [[ "$branch_name" == *"break"* ]]; then
    major=$((major + 1))
    minor=0
    patch=0
elif [[ "$branch_name" == *"feature"* ]]; then
    minor=$((minor + 1))
    patch=0
elif [[ "$branch_name" == *"bugfix"* || "$branch_name" == *"patch"* || "$branch_name" == *"reduce"* ]]; then
    patch=$((patch + 1))
fi

current_time=$(date +"%Y-%m-%d %H:%M:%S")
new_tag="$major.$minor.$patch"
tag_message="Version $version ($current_time)"

echo $current_time
echo $new_tag
echo $tag_message
