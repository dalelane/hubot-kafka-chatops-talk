# ChatOps : Why you should be talking to your Kafka cluster

This repo contains the demo for a conference presentation about ChatOps.

If you just want to see a list of the tools we used, see [LINKS.md](./LINKS.md).

Running the `initial-setup.sh` script will deploy the whole demo to an OpenShift cluster.

The other shell scripts are scripts that we use at various points through the presentation.

We're not sharing this because we expect anyone to run the whole thing and recreate the whole demo we showed in the talk - it deploys a very contrived collection of tech, that we needed to be able to tell the ChatOps story we wanted to tell. As a complete thing, it's probably not going to be super useful to anyone else.

**But** we are hoping that the talk will inspire a few people to give ChatOps a try in their own environment. We want to make it easy for those people to borrow any ideas that we showed that they think might fit their requirements. Sharing the demo that you can look through was the easiest way for us to enable that.

That said, if you want to set up your whole instance of the complete end-to-end demo we showed, you're very welcome to! The notes below might help you get started...

## Running the demo

### Changes you have to make

#### Set up access to Slack

Rename `./hubot/hubot-slack-secret-template.yaml` to `./hubot/hubot-slack-secret.yaml`

Rename `./prometheus-server/alertmanager-slack-apikey-template.yaml` to `./prometheus-server/alertmanager-slack-apikey.yaml`

Update the contents in both to replace:
- `xoxb-supersecrettoken` with a token for an Incoming Webhook with access to Slack
- `U0000000000` with the user id in Slack for the user you want Hubot to recognise as the administrator

#### Set up access to PagerDuty

Rename `./hubot/hubot-pagerduty-secret-template.yaml` to `./hubot/hubot-pagerduty-secret.yaml`

Update the contents with the configuration details from your PagerDuty hubot integration

### Changes you may want to make

If you're going to run this demo in your own environment, there are probably a few changes you will want to make:

#### Change the storage class used by the Kafka cluster
I'm using `ibmc-file-gold-gid` but you will likely need to choose a storage class that is available in your Kubernetes cluster.

You can find this in:
- `./kafka-cluster/kafka.yaml`

#### Change from `Routes`
I'm using routes to define external ingress into the OpenShift cluster, but this is an OpenShift-specific extension to Kubernetes. If you're not running in OpenShift, you will want to look at changing this to something like `Ingress` or `NodePort`.

You can find this in:
- `./prometheus-server/alertmanager-route.yaml`
- `./prometheus-server/prometheus-route.yaml`

#### Change from `SecurityContextConstraints` (SCCs)
I'm using SCCs to grant permissions to the Hubot deployment, but this is an OpenShift-specific extension to Kubernetes. If you're not running in OpenShift, you will need to replace these with something appropriate for your environment..

You can find these in:
- `./hubot/hubot-scc.yaml`
- `./hubot/redis-scc.yaml`

#### Build your own Hubot
You can just use the Hubot image used in the demo, but if you want to make changes, you will need to build your own Hubot Docker image.

You will need to update the Docker image location in a few places:
- `./00-build-hubot.sh`
- `./hubot/hubot-deployment.yaml`

