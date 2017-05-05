#
# Build a docker image to build the website,
# then build a docker image to serve it.
# If xmpp.org repo is checked out (in ./xmpp.org),
# then build the website from the latest commit here.
# (This commit must be pushed...)
#

COMMIT_HASH=$([-d xmpp.org] && cd xmpp.org && git rev-parse HEAD)

all: deployer

deployer: builder
	docker build -t xmpp-org/latest deploy

builder:
	docker build --build-arg COMMIT_HASH=${COMMIT_HASH} -t xmpp-org-build/latest build
