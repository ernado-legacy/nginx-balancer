#!/bin/bash

set -eo pipefail

export ETCD_PORT=${ETCD_PORT:-4001}
export HOST_IP=${HOST_IP:-172.17.42.1}
export ETCD=$HOST_IP:$ETCD_PORT
export ETCDCTL_PEERS="http://$ETCD"

confd -interval 10 -watch=true &
echo "[nginx-balancer] confd is now monitoring etcd for changes"
echo "[nginx-balancer] starting nginx"
nginx