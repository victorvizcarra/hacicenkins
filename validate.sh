#!/bin/bash

pattern="^arn:aws:secretsmanager:\S+:\d+:secret:\S+$"

yq r c.yaml us-east-2.stage.secrets_from | 
while read -r ENV
read -r VALUE
do 
  SECRETARN=$(echo $VALUE | sed 's/valueFrom: //g')
  if ! echo $SECRETARN  | grep -E $pattern 
  then
	echo "Not valid arn $SECRETARN"
  fi
done

#echo $key  | grep -E  "^arn:aws:secretsmanager:\S+:\d+:secret:\S+$"
#[[ $key  =~ $pattern ]] &&	echo "match"
