CREATE TABLE semantic_version (
    id BIGINT UNSIGNED PRIMARY KEY,
    project VARCHAR(255) NOT NULL,
    major INTEGER NOT NULL,
    minor INTEGER NOT NULL,
    patch INTEGER NOT NULL,
    commit_hash CHAR(40) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    description TEXT NOT NULL,

    KEY project_list_idx (project, created_at),
    KEY project_version_idx (project, major, minor, patch),
    KEY project_commit_idx (project, commit_hash)
);
