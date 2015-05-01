#!/bin/bash

# Manually copy over upstream templates
# TODO: Normally the pipeline will do this if upstream templates git repo changes

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

bosh_release_path=$1; shift
stage=$1; shift

usage() {
  echo "USAGE: ./bin/update_release_templates.sh path/to/boshrelease [stage-dir]"
  exit
}
if [[ "${bosh_release_path}X" == "X" ]]; then
  usage
fi
if [[ ! -d ${bosh_release_path}/templates ]]; then
  usage
fi
stage=${stage:-"try-anything"}
bosh_release_templates_path="${bosh_release_path}/templates"
release_name=$(basename ${bosh_release_path})

set -e
target_dir="${stage}/pipeline/${release_name}"

echo "Copying ${bosh_release_path} into ${target_dir}"
rm -rf ${target_dir}
mkdir -p ${target_dir}
cp -r ${bosh_release_templates_path}/* ${target_dir}/
