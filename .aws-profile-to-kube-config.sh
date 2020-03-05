#!/usr/bin/env bash
source .env

profile=${1:?'aws profile name argument is required'}

strip() {
  local STRING=${1#$"$2"}
  echo ${STRING%$"$2"}
}

profile=$(strip $profile "[")
profile=$(strip $profile "]")

echo "Generating kubectl config with aws  \"${profile}\" profile..."

if aws --profile $profile eks list-clusters --region $_region &> /dev/null; then
  for cluster in $(aws --profile $profile eks list-clusters --region $_region | jq -r ".clusters | .[]"); do
    aws eks update-kubeconfig --name $cluster --profile $profile
  done
else
  echo "Warning: the profile \"${profile}\" has not eks clusters"
  exit 1
fi
