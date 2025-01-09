#!/bin/bash

set -ex

VOLUME_NAME="pg_data_volume"
POSTGRES_IMAGE="${POSTGRES_IMAGE:-postgres:16-alpine}"
HOST_FOLDER="/mnt/postgres"

CLAIR_VERSION="${CLAIR_VERSION:-4.7.4}"
CLAIR_LOCAL_SCAN_IMAGE="${CLAIR_LOCAL_SCAN_IMAGE:-arminc/clair-local-scan-v4}"

# Step 1: Create Docker volume with specific host folder
echo "Creating Docker volume backed by ${HOST_FOLDER}..."

sudo mkdir -p "${HOST_FOLDER}"
sudo chmod 755 /mnt/postgres
sudo chown $(whoami):$(whoami) /mnt/postgres

docker volume create \
  --driver local \
  --opt type=none \
  --opt device="${HOST_FOLDER}" \
  --opt o=bind \
  "${VOLUME_NAME}"

# Step 2: Start PostgreSQL container with the volume
echo "Starting PostgreSQL container with volume..."
docker pull ${POSTGRES_IMAGE}
docker run -d --name postgres -e 'PGDATA=/var/lib/postgresql/clair' -e POSTGRES_PASSWORD=password -v ${VOLUME_NAME}:/var/lib/postgresql/clair ${POSTGRES_IMAGE}

# Wait for PostgreSQL to initialize (adjust as needed)
echo "Waiting for PostgreSQL to initialize..."
sleep 20

RETRY_INTERVAL=5       # Time in seconds between retries
MAX_RETRIES=30         # Maximum number of retries before failing

# Loop to check PostgreSQL readiness
for ((i=1; i<=MAX_RETRIES; i++)); do
  echo "Attempt ${i}: Checking if PostgreSQL is ready..."
    
  docker run --rm --link postgres:postgres -e PGPASSWORD=password ${POSTGRES_IMAGE} pg_isready -U postgres -h postgres
    
  if [ $? -eq 0 ]; then
    echo "PostgreSQL is ready!"
    break
  else
    echo "PostgreSQL is not ready. Retrying in ${RETRY_INTERVAL} seconds..."
    sleep ${RETRY_INTERVAL}
  fi
done

if [ ${i} -gt ${MAX_RETRIES} ]; then
    echo "PostgreSQL did not become ready after ${MAX_RETRIES} attempts."
    exit 1
else
    echo "Continuing to start clair."
fi

docker run -d --name clair --link postgres:postgres "${CLAIR_LOCAL_SCAN_IMAGE}"

echo "Waiting for Clair to initialize..."
sleep 10

docker ps -a
