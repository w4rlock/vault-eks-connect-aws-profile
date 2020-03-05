#!/usr/bin/env bash
source .env

vault_key=${1:?'vault key argument is required'}
cred=${2:?'credential file is required'}

echo "Processing - Parsing profile \"${vault_key}\" with \"${cred}\" file..."

eks_cluster_name=$(cat $cred | jq -r ".data | .cluster_name")
aws_profile=$(cat ${cred} | jq -r ".data | .aws_profile")
access_key=$(cat ${cred} | jq -r ".data | .aws_access_key_id")
secret_key=$(cat ${cred} | jq -r ".data | .aws_secret_access_key")

[ "${access_key}" == *"null"* ] && exit 1
[ "${profile}" == *"null"* ] && exit 1
[ "${profile}" == "[]" ] && exit 1

# skip duplicates
if grep -F "[${vault_key}]" $_creds_file &> /dev/null; then
  echo "Skipping duplicate profile ${profile}..."
  exit 1
fi

# fix aws credentials file for duplicated access key with differents profiles
if grep -F $access_key $_creds_file &> /dev/null; then
  echo "Skipping duplicate access_key ${access_key}..."
  exit 1
fi

printf "\n\n# ---------------- \n" >> $_creds_file
echo "#@[${aws_profile}]@" >> $_creds_file
echo "[${vault_key}]" >> $_creds_file

echo "aws_access_key_id = ${access_key}" >> $_creds_file
echo "aws_secret_access_key = ${secret_key}" >> $_creds_file
echo "region = ${_region}" >> $_creds_file

echo "Aws profile \"${vault_key}\" created..."