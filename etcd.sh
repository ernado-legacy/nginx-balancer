#!/bin/bash

export ETCD_PORT=${ETCD_PORT:-4001}
export PEER_PORT=${PEER_PORT:-7001}
export HOST_IP=${HOST_IP:-172.17.42.1}
export ETCD=$HOST_IP:$ETCD_PORT
export PEER=$HOST_IP:$PEER_PORT
export ETCDCTL_PEERS="http://$ETCD"

docker rm -f etcd
docker run -d --name etcd -p $PEER_PORT:$PEER_PORT -p $ETCD_PORT:$ETCD_PORT coreos/etcd \
	-addr=$ETCD -peer-addr=$PEER
sleep 2

until etcdctl ls; do 
	sleep 1
done

echo "etcd up"