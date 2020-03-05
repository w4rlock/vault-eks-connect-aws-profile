#!/usr/bin/env bash

source .env

for k in $(cat $_vault_cache_file | jq -r ".data | .keys | .[]" | rg khatu); do
    echo "Fetching profile ${k}..."
    ./vault-fetch.sh "$k" > ".creds/${k}.cred"
    sleep .5
done