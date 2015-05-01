#!/bin/bash

source_stage_dir=$1; shift
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [[ ! -d $source_stage_dir ]]; then
  echo "USAGE: ./bin/copy_assets.sh path/to/stage_dir"
fi

set -e
cd $DIR/..

rm -rf bin
rm -rf pipeline
rm -rf releases
rm -rf stemcell

cp -r ${source_stage_dir}/bin .
cp -r ${source_stage_dir}/pipeline .

mkdir -p manifests
cp -r ${source_stage_dir}/manifests/pipeline-inputs.yml manifests/
