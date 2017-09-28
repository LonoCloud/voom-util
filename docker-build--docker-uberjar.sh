#!/bin/bash

set -e

function do_build() {
	lein voom build-deps && lein voom wrap docker-uberjar build
}

function do_push() {
    if [ -z "$DOCKER_PUSH_PREFIXES" ]; then
	echo "DOCKER_PUSH_PREFIXES unset. Nothing to push."
    else
	while read tag; do
	    for prefix in $DOCKER_PUSH_PREFIXES; do
		if [[ "$tag" =~ ^${prefix} ]]; then
		    echo "Pushing: $tag"
		    "$@" "$tag"
		fi
	    done
	done
    fi
}

exemplar="Warning: specified :main without including it in :aot.
Implicit AOT of :main will be removed in Leiningen 3.0.0.
If you only need AOT for your uberjar, consider adding :aot :all into your
:uberjar profile instead.
Compiling 4 source files to /home/abrooks/repos/sdp-api/modules/sdp-http-api/target/classes
Compiling viasat.sdp.api.main
Created /home/abrooks/repos/sdp-api/modules/sdp-http-api/target/sdp-http-api-0.7.0-20160728_200632-g5e3754e.jar
Created /home/abrooks/repos/sdp-api/modules/sdp-http-api/target/sdp-http-api-0.7.0-20160728_200632-g5e3754e-standalone.jar
Built docker image: sha256:b5c33ddbaf1bc9194306eb9e3c65af94b90656ed18fb930053c2471139bfa5a3
Tagged image as: viasat/sdp-http-api:0.7.0-20160728_200632-g5e3754e
Tagged image as: 174484605794.dkr.ecr.us-west-2.amazonaws.com/viasat/sdp-http-api:0.7.0-20160728_200632-g5e3754e"

TAG_LINE="^Tagged image as: "

function usage() {
    echo "Usage:"
    echo "  $0 <build|build-push|test-push>"
    exit 1
}

case "$1" in
    build) do_build ;;
    build-push) do_build |grep "$TAG_LINE" |sed "s/${TAG_LINE}//" |do_push docker push;;
    test-push) echo "$exemplar" |grep "$TAG_LINE" |sed "s/${TAG_LINE}//" |do_push echo "No action - test push:";;
    *) usage ;;
esac
