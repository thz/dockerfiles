#!/bin/bash

kubectl create secret generic \
	spofgresql-password \
	--from-file=POSTGRES_PASSWORD=<(base64 -w0 /dev/urandom | head -c 16)

