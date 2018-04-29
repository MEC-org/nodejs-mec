#!/bin/bash
set -u
set -e

# nohup constellation-node constellation.config &> constellation.log &
geth --datadir Blockchain/$1 init Quorum/quorum-genesis.json &>> /dev/null

sleep 5

FLAGS="--datadir Blockchain/$1 --shh --port $2 --raft"
echo $FLAGS

RPC_API="admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,raft"
HTTP_RPC_ARGS="--rpc --rpcaddr 0.0.0.0 --rpcport $3 --rpcapi $RPC_API"
WS_RPC_ARGS="--ws --wsaddr 0.0.0.0 --wsport $4 --wsapi $RPC_API --wsorigins=*"

RAFT_ARGS="--raftport $5"

if [ "$6" == "permissionedNodes" ]
  then
  RAFT_ARGS="$RAFT_ARGS --permissioned Blockchain"
fi
if [ "$#" == 7 ]
  then
  RAFT_ARGS="$RAFT_ARGS --raftjoinexisting $7"
fi

ALL_ARGS="$FLAGS $HTTP_RPC_ARGS $WS_RPC_ARGS $RAFT_ARGS"

geth $ALL_ARGS &> gethNode.log &

echo "[*] Node started"