#!/bin/sh

VERSION=70

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
mv kubectl hubot/hubot-image/.

docker build hubot/hubot-image -t dalelane/hubot:$VERSION
docker push dalelane/hubot:$VERSION
