#!/bin/bash
set -e

current_directory="$PWD"

cd $(dirname $0)/..

docker-compose up -d

result=$?

cd "$current_directory"

exit $result
