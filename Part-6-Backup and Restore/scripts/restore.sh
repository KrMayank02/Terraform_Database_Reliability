#!/usr/bin/env bash
set -euo pipefail

# Configuration
CONTAINER_NAME="local_hotel_db"
DB_USER="postgres"
TARGET_DB="hotel_db"

# Check if backup file path was provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <path_to_backup_file.sql.gz>" >&2
  echo "Example: $0 backups/hotel_db_backup_20260921_120000.sql.gz" >&2
  exit 1
fi

BACKUP_FILE="$1"

if [ ! -f "${BACKUP_FILE}" ]; then
  echo "Error: Backup file '${BACKUP_FILE}' not found!" >&2
  exit 1
fi

echo "Starting database restore..."
echo "Source File      : ${BACKUP_FILE}"
echo "Target Container : ${CONTAINER_NAME}"

# Decompress and stream the dump directly into psql in the container
gunzip -c "${BACKUP_FILE}" | docker exec -i "${CONTAINER_NAME}" psql -U "${DB_USER}" -d "postgres"

echo "Database restore completed successfully!"