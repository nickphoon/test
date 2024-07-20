#!/usr/bin/env sh

echo 'Building the Docker image for the Flask app...'
set -x
docker build -t flask-app .
set +x

echo 'Stopping any running containers on port 5000...'
set -x
docker ps --filter publish=5000 --format "{{.ID}}" | xargs -r docker stop
docker ps -a --filter status=exited --filter publish=5000 --format "{{.ID}}" | xargs -r docker rm
set +x

echo 'Starting the new Flask app container...'
set -x
docker run -d -p 5000:5000 flask-app
set +x

echo 'Giving the server a moment to start...'
sleep 10

echo 'Checking if the Flask app is running...'
set -x
curl -s http://localhost:5000 || echo "Flask app did not start"
set +x
