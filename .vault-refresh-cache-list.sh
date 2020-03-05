#!/usr/bin/env bash
source .env

curl -sk -H "X-Vault-Token: ${_vault_token}" \
    --request LIST "${_vault_corp_url}" | tee $_vault_cache_file