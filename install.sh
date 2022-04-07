#!/bin/bash

DOCKER_REPO="https://raw.githubusercontent.com/kubicek/bullet_train_docker/main"

# install and execute and alternate configuration script
curl -o "bin/configure" "$DOCKER_REPO/bin/configure"
bin/configure

# install docker configuration
curl -o "Dockerfile" "$DOCKER_REPO/Dockerfile"
curl -o "docker-compose.yml" "$DOCKER_REPO/docker-compose.yml"

# puma should not listen to localhost only
sed -i '' 's/-p 3000/-p 3000 -b 0.0.0.0/' Procfile.dev

# commit changes
git add .
git commit -m "Added docker"

# build image
docker compose build

# replay instructions from configure
echo "Next you can run `docker compose run web bin/setup` and then `docker compose up`."
