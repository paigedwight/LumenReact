#!/usr/bin/env bash

set -e

declare repoDir="$(git rev-parse --show-toplevel)"
declare image="$(docker build --target dev -q "$repoDir/web")"
docker run --rm -it -v "$repoDir/web:/usr/src/app" "$image" npm "$@"
