#!/bin/bash

set -eo pipefail

export ETCD_PORT=${ETCD_PORT:-4001}
export HOST_IP=${HOST_IP:-172.17.42.1}
export ETCD=$HOST_IP:$ETCD_PORT
export ETCDCTL_PEERS="http://$ETCD"

echo "[nginx-balancer] booting container. ETCD: $ETCD"

etcdctl --peers="http://$ETCD" ls

# Try to make initial configuration every 5 seconds until successful
until confd -onetime; do
    echo "[nginx-balancer] waiting for confd to create initial nginx configuration"
    sleep 1
done

# Put a continual polling `confd` process into the background to watch
# for changes every 10 seconds
confd -interval 10 -watch=true &
echo "[nginx-balancer] confd is now monitoring etcd for changes"

# Start the Nginx service using the generated config
echo "[nginx-balancer] starting nginx"
nginx