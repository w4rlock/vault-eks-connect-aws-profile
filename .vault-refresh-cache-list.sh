#!/usr/bin/env bash

echo "Creating vault cache list \"${_vault_cache_file}\"..."

curl -sk -H "X-Vault-Token: ${_vault_token}" \
    --request LIST "${_vault_corp_url}" | jq -r > $_vault_cache_file