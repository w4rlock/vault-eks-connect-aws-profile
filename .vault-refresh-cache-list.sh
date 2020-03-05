#!/usr/bin/env bash

curl -sk -H "X-Vault-Token: ${_vault_token}" \
    --request LIST "${_vault_corp_url}" | jq -r >> $_vault_cache_file