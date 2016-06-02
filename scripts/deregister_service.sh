#!/bin/bash

SERVICE=$1
ADDRESS=$2

curl -k -u $INFORMATION_SERVICE_LOGIN:$INFORMATION_SERVICE_PASSWORD -X DELETE --data "address=$ADDRESS" https://localhost:11300/$SERVICE
echo ""

