XSF Website Building
================

How to use this repository to build a copy of the website:

Clone
----

You'll first need to clone the repostory. Do so with --recursive,
if possible: `git clone --recursive https://github.com/dwd/xsf-web-docker` -
this will clone the website source itself as well.

If you didn't, you can pull in the website itself by either:

`git submodule update --init`

Or simply linking the website into place with something like:

`rmdir xmpp.org; ln -s /my/copy/of/xmpp.org .`

Build
----

The Makefile will build the website completely just by `make`. It'll do
the following:

* Create a build Docker image (`make builder`) which is a development
environment with a complete set of dependencies ready.

* Run this docker image on the xmpp.org directory locally. This directory
is presumed to contain a checked out repository for the website. (`make site`)

* From the newly created static files in `deploy/output`, it will then create
a minimalist docker image to actually serve the website. (`make deployer`)

Serve
----

For development convenience, you can run the website on port 8080 by `make serve`

