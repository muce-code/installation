#!/bin/bash
DEBIAN_FRONTEND=noninteractive apt-get remove docker docker-engine docker.io containerd runc

DEBIAN_FRONTEND=noninteractive apt-get update && apt install -y \
    openjdk-11-jdk-headless \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    git \
    curl

JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

DEBIAN_FRONTEND=noninteractive apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io

curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

git clone https://github.com/muce-code/installation.git ./installation

mkdir -p /opt/muce/data /opt/muce/muce-api /opt/muce/nginx /opt/muce/traefik
cp ./installation/docker-compose.yml /opt/muce/
cp ./installation/nginx/nginx.conf /opt/muce/nginx/
cp ./installation/nginx/fastcgi-php.conf /opt/muce/nginx

docker build -t muce-code:latest ./installation/muce-code/

git clone https://github.com/muce-code/muce-api.git ./muce-api

cp ./muce-api/src/main/resources/config.yml /opt/muce/muce-api/config.yml

chmod +x ./muce-api/gradlew

cd ./muce-api
./gradlew shadowJar

cd ..
mkdir -p ./muce-api-docker
cp ./muce-api/build/libs/MuceAPI-all.jar ./muce-api-docker/
cp ./installation/muce-api/Dockerfile ./muce-api-docker/


cd ./muce-api-docker

docker build -t muceapi:latest ./

docker network create muce-traefik

cd /opt/muce

chmod a+rw -R /opt/muce/
