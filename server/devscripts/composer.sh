#!/usr/bin/env bash

set -e

declare repoDir="$(git rev-parse --show-toplevel)"
declare image="$(docker build --target dev -q "${repoDir}/server")"

if [ "$1" == "install" ]; then
    set -- install --ignore-platform-reqs --no-interaction --no-scripts "${@:2}"
fi

docker run --rm -it --workdir /var/www -v "${repoDir}/server:/var/www" "$image" composer "$@"
