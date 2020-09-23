#!/bin/sh

SATELLITE_REGION=${SATELLITE_REGION:-EUROPE}
if [[ "${SATELLITE_REGION}" == "EUROPE" ]]; then
    SATELLITE_ADDRESS=${SATELLITE_ADDRESS:-europe-west-1.tardigrade.io}
elif [[ "${SATELLITE_REGION}" == "ASIA" ]]; then
    SATELLITE_ADDRESS=${SATELLITE_ADDRESS:-asia-east-1.tardigrade.io}
elif [[ "${SATELLITE_REGION}" == "US" ]]; then
    SATELLITE_ADDRESS=${SATELLITE_ADDRESS:-us-central-1.tardigrade.io}
fi

if [[ -z "${SATELLITE_ADDRESS}" ]]; then
    echo "SATELLITE_ADDRESS is not set" 1>&2
    exit 1
fi

if [[ -z "${API_KEY}" ]]; then
    echo "API_KEY is not set" 1>&2
    exit 1
fi

if [[ -z "${PASSPHRASE}" ]]; then
    echo "PASSPHRASE is not set" 1>&2
    exit 1
fi

gateway setup  --non-interactive --satellite-address "${SATELLITE_ADDRESS}" --api-key "${API_KEY}" --passphrase "${PASSPHRASE}"
SETUP_STATUS=$?
if [[ "${SETUP_STATUS}" -ne 0 ]]; then
    echo "Setup failed!" 1>&2
    exit ${SETUP_STATUS}
fi

gateway run --server.address 0.0.0.0:7777
