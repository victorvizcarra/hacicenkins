#!/usr/bin/env bash

set -euf -o pipefail



if [ "$#" -ne 2 ]; then
  echo "Usage: $0 AWS_REGION LUMINARY_ENV " >&2
  exit -1
fi

AWS_REGION=$1
LUMINARY_ENV=$2

pwd
export PATH=$PATH:~/scripts
#trim spaces with xargs
lines=$(yq r config.yml $AWS_REGION.$LUMINARY_ENV.environment_variables | wc -l | xargs)

if [ "$lines" -eq 0 ]; then
  echo "invalid configs for $AWS_REGION - $LUMINARY_ENV"
   exit -1
fi

pattern="^arn:aws:secretsmanager:\S+:\d+:secret:\S+$"
(yq r config.yml $AWS_REGION.$LUMINARY_ENV.secrets_from || exit -1) | 
while read -r ENV
read -r VALUE
do 
  SECRETARN=$(echo $VALUE | sed 's/valueFrom: //g')
  if ! echo $SECRETARN  | grep -E $pattern 
  then
	echo "Not valid arn $SECRETARN"
	exit -1
  fi
done
