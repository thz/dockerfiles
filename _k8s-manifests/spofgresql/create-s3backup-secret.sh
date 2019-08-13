#!/bin/bash

echo -n "s3 backup AWS_ACCESS_KEY_ID: "
read AWS_ACCESS_KEY_ID

echo -n "s3 backup AWS_SECRET_ACCESS_KEY: "
read AWS_SECRET_ACCESS_KEY

kubectl create secret generic spofgresql-s3-backup \
	--from-literal=AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" \
	--from-literal=AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"

