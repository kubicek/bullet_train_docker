#!/bin/bash

# install docker and alternate configuration script
DOCKER_REPO="https://raw.githubusercontent.com/kubicek/bullet_train_docker/main"
curl -o "Dockerfile" "$DOCKER_REPO/Dockerfile"
curl -o "docker-compose.yml" "$DOCKER_REPO/docker-compose.yml"
curl -o "bin/configure" "$DOCKER_REPO/bin/configure"

# modify files for more complex docker setup
sed -i 's/-p 3000/-p 3000 -b 0.0.0.0/' Procfile.dev
# not yet sure if needed
#  insert_into_file "config/cable.yml", "  url: <%= ENV.fetch(\"REDIS_URL\") %>\n", :after => "adapter: redis\n"

git add .
git commit -m "Added docker"

bin/configure

docker compose build
