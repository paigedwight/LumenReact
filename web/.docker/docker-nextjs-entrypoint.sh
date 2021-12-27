#!/bin/sh
set -ex

npm install

exec npm run dev "$@"
