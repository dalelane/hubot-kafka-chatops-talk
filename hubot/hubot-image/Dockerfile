FROM node:lts-alpine

RUN apk update \
 && apk upgrade \
 && apk add jq \
 && npm install -g yo generator-hubot \
 && rm -rf /var/cache/apk/*

COPY kubectl /usr/local/bin/kubectl

RUN addgroup -g 501 hubot\
 && adduser -D -h /hubot -u 501 -G hubot hubot
ENV HOME /home/hubot
WORKDIR $HOME
COPY run.sh ./
COPY external-scripts.json overrides-external-scripts.json
RUN chown -R hubot:hubot .
RUN chmod +x run.sh
RUN chown -R hubot:hubot /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl
USER hubot

RUN yo hubot \
 --name="chatops-demo-bot" \
 --description="Showing how to get started with ChatOps" \
 --owner="Dale Lane <dale.lane@uk.ibm.com>" \
 --adapter=slack \
 --defaults
RUN cp overrides-external-scripts.json external-scripts.json

EXPOSE 8080

ENTRYPOINT ["./run.sh"]

CMD ["--name", "$HUBOT_NAME", "--adapter", "slack"]
