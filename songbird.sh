#!/bin/bash
export FBA_VALs=/flare/scripts/configs/songbird/validators.json
/flare/avalanchego \
  --network-id=songbird \
  --http-host=0.0.0.0 \
  --data-dir=/flare/.flare \
  --bootstrap-ips="$(curl -m 10 -sX POST --data '{ "jsonrpc":"2.0", "id":1, "method":"info.getNodeIP" }' -H 'content-type:application/json;' https://songbird.flare.network/ext/info | jq -r ".result.ip")" \
  --bootstrap-ids="$(curl -m 10 -sX POST --data '{ "jsonrpc":"2.0", "id":1, "method":"info.getNodeID" }' -H 'content-type:application/json;' https://songbird.flare.network/ext/info | jq -r ".result.nodeID")"