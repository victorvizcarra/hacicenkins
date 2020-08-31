#!/usr/bin/bash

set -e

curl -L -o /usr/local/bin/yq  https://github.com/mikefarah/yq/releases/download/3.3.2/yq_linux_amd64 && chmod 755 /usr/local/bin/yq

pattern="^arn:aws:secretsmanager:\S+:\d+:secret:\S+$"
echo "exit 1 test"
(/usr/local/bin/yq r config.yml us-east-2.stage.secrets_from || exit -1) | 
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

#echo $key  | grep -E  "^arn:aws:secretsmanager:\S+:\d+:secret:\S+$"
#[[ $key  =~ $pattern ]] &&	echo "match"
