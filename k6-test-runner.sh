#!/bin/bash

docker pull loadimpact/k6
docker run --network="host" -i loadimpact/k6 run --vus 10 -i 1000 - <k6-script.js
