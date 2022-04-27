#!/bin/sh

whoami
id

ls -l /home/hubot/

if [ -n "$EXTRA_PACKAGES" ]; then
  printf "\\n********* Installing extra packages *********\\n"
  npm install --save ${EXTRA_PACKAGES//,/ }
fi

HUBOT_VERSION=$(jq -r '.dependencies.hubot' package.json)

printf "\\n********* package.json *********\\n"
cat package.json

printf "\\n****************** Starting %s (Hubot %s) ******************\\n" "$HUBOT_NAME" "${HUBOT_VERSION}"

bin/hubot "$@"
