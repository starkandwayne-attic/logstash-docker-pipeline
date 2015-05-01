#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source_stage_dir=$1; shift
if [[ ! -d $source_stage_dir ]]; then
  echo "USAGE: ./bin/reuse_assets_make_manifest_and_save.sh path/to/stage_dir"
fi

manifest=${manifest:-"manifests/manifest.yml"}

set -e

cd $DIR/..
mkdir -p manifests

rm -rf bin
rm -rf pipeline
rm -rf releases
rm -rf stemcell

cp -r ${source_stage_dir}/bin .
cp -r ${source_stage_dir}/pipeline .

mkdir -p manifests
cp -r ${source_stage_dir}/manifests/pipeline-inputs.yml manifests/

./bin/make_manifest.sh $@ > $manifest
