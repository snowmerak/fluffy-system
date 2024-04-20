-- name: GetSemantics :many
SELECT * FROM semantic_version WHERE project = ? AND created_at < ? ORDER BY created_at DESC LIMIT ?;

-- name: GetSemanticByCommit :one
SELECT * FROM semantic_version WHERE project = ? AND commit_hash = ?;

-- name: GetSemanticByVersion :many
SELECT * FROM semantic_version WHERE project = ? AND major = ? AND minor = ? AND patch = ?;

-- name: GetAllSemantics :many
SELECT * FROM semantic_version;

-- name: InsertSemantic :execresult
INSERT INTO semantic_version (project, major, minor, patch, commit_hash, description) VALUES (?, ?, ?, ?, ?, ?);

-- name: UpdateSemantic :execresult
UPDATE semantic_version SET description = ? WHERE project = ? AND major = ? AND minor = ? AND patch = ?;