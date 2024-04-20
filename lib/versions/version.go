package versions

import (
	"fmt"
	"regexp"
	"strconv"
)

func (v SemanticVersion) UpdateMajor() SemanticVersion {
	return SemanticVersion{
		Major: v.Major + 1,
		Minor: 0,
		Patch: 0,
	}
}

func (v SemanticVersion) UpdateMinor() SemanticVersion {
	return SemanticVersion{
		Major: v.Major,
		Minor: v.Minor + 1,
		Patch: 0,
	}
}

func (v SemanticVersion) UpdatePatch() SemanticVersion {
	return SemanticVersion{
		Major: v.Major,
		Minor: v.Minor,
		Patch: v.Patch + 1,
	}
}

func (v SemanticVersion) String() string {
	return fmt.Sprintf("v%d.%d.%d", v.Major, v.Minor, v.Patch)
}

var semanticVersionRegex = regexp.MustCompile(`^v([0-9]+)\.([0-9]+)\.([0-9]+)$`)

func IsValid(version string) bool {
	return semanticVersionRegex.MatchString(version)
}

func NewSemantic(project string, major int32, minor int32, patch int32, commitHash string) SemanticVersion {
	return SemanticVersion{
		Project:    project,
		Major:      major,
		Minor:      minor,
		Patch:      patch,
		CommitHash: commitHash,
	}
}

func ParseSemanctic(version string) (SemanticVersion, error) {
	matches := semanticVersionRegex.FindStringSubmatch(version)
	if len(matches) == 0 {
		return SemanticVersion{}, fmt.Errorf("invalid version")
	}

	major := matches[1]
	minor := matches[2]
	patch := matches[3]

	parsedMajor, err := strconv.ParseInt(major, 10, 32)
	if err != nil {
		return SemanticVersion{}, fmt.Errorf("invalid major version: %w", err)
	}
	parsedMinor, err := strconv.ParseInt(minor, 10, 32)
	if err != nil {
		return SemanticVersion{}, fmt.Errorf("invalid minor version: %w", err)
	}
	parsedPatch, err := strconv.ParseInt(patch, 10, 32)
	if err != nil {
		return SemanticVersion{}, fmt.Errorf("invalid patch version: %w", err)
	}

	return SemanticVersion{
		Major: int32(parsedMajor),
		Minor: int32(parsedMinor),
		Patch: int32(parsedPatch),
	}, nil
}
