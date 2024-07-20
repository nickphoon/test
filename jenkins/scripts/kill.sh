#!/usr/bin/env sh

echo 'Stopping the Flask app container...'
set -x
docker ps --filter publish=5000 --format "{{.ID}}" | xargs -r docker stop
set +x
