#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
manifest=${manifest:-"manifests/manifest.yml"}

set -e

cd $DIR/..
mkdir -p manifests
./bin/make_manifest.sh $@ > $manifest
