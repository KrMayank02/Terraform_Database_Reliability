#!/usr/bin/env bash
set -euo pipefail

# Configuration
CONTAINER_NAME="local_hotel_db"
DB_USER="postgres"
DB_NAME="hotel_db"
BACKUP_DIR="$(pwd)/backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="${BACKUP_DIR}/hotel_db_backup_${TIMESTAMP}.sql.gz"

# Create backups directory if it doesn't exist
mkdir -p "${BACKUP_DIR}"

echo "Starting database backup..."
echo "Target Container : ${CONTAINER_NAME}"
echo "Target Database  : ${DB_NAME}"

# Execute pg_dump inside docker container and compress on the fly
docker exec "${CONTAINER_NAME}" pg_dump -U "${DB_USER}" --clean --if-exists --create "${DB_NAME}" | gzip > "${BACKUP_FILE}"

if [ -f "${BACKUP_FILE}" ]; then
  FILE_SIZE=$(du -h "${BACKUP_FILE}" | cut -f1)
  echo "Backup completed successfully!"
  echo "Saved to: ${BACKUP_FILE} (${FILE_SIZE})"
else
  echo "Backup failed!" >&2
  exit 1
fi