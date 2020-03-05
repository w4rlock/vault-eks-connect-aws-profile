#!/usr/bin/env bash
source .env

proj=${1:?"Project is required"}

curl -sk \
  -H "X-Vault-Token: ${_vault_token}" \
  -H 'Content-Type: application/json' \
  -X GET \
  "${_vault_corp_url}/${proj}" | jq