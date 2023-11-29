#!/bin/bash
echo "Running volume permissions sidecar.sh"
adduser -uid 1000 --disabled-password --gecos "" user 
chown -R 1000:1000 /prometheus
echo "Permissions changed"
exit 0