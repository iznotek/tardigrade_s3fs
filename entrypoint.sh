#!/bin/sh

#gateway setup --advanced --help

if [[ -z "${ACCESS_GRANT}" ]]; then
    echo "ACCESS_GRANT is not set" 1>&2
    exit 1
fi

if [[ -z "${MINIO_ACCESS_KEY}" ]]; then
    echo "ACCESS_GRANT is not set" 1>&2
    exit 1
fi

if [[ -z "${MINIO_SECRET_KEY}" ]]; then
    echo "ACCESS_GRANT is not set" 1>&2
    exit 1
fi

gateway setup  --non-interactive --access "${ACCESS_GRANT}" --minio.access-key "${MINIO_ACCESS_KEY}" --minio.secret-key "${MINIO_SECRET_KEY}"
SETUP_STATUS=$?
if [[ "${SETUP_STATUS}" -ne 0 ]]; then
    echo "Setup failed!" 1>&2
    exit ${SETUP_STATUS}
fi

gateway run --server.address 0.0.0.0:7777
