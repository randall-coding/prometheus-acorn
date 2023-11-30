#!/bin/bash
echo "Running volume permissions sidecar.sh"
chown -R 65534:65534 /prometheus
echo "Permissions changed"
exit 0