BUCKET="umroh"
BACKUP_ROOT="$HOME/minio-backups" # lcoate
STAMP="$(date +%F)"
NET="minio_minionetwork" # docker network ls

mkdir -p "$BACKUP_ROOT/${BUCKET}-${STAMP}"

docker run --rm --network "$NET" \
  --user "$(id -u)":"$(id -g)" \
  -e 'MC_HOST_minio=http://username_login:password_login@minio:9000' \
  -e 'HOME=/tmp' \
  -e 'MC_CONFIG_DIR=/tmp/mc' \
  -v "${BACKUP_ROOT}:/backups" \
  minio/mc:latest \
  cp --recursive "minio/${BUCKET}" "/backups/${BUCKET}-${STAMP}"
