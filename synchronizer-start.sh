#!/bin/bash

if redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT}  ping | grep 'PONG' ; then

  docker pull splitsoftware/split-synchronizer

  docker run --rm --name split-synchronizer \
   -p 3010:3010 \
   -e SPLIT_SYNC_API_KEY=${SPLITIO_API_KEY} \
   -e SPLIT_SYNC_REDIS_HOST=${REDIS_HOST} --network="host" \
   -e SPLIT_SYNC_REDIS_PORT=${REDIS_PORT} \
   splitsoftware/split-synchronizer
else
 echo "No redis cache, no synchronizer"
fi

