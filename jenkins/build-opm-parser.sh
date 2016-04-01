#!/bin/bash

function build_opm_parser {
  # Build ERT
  git clone --single-branch --depth 1 -b master https://github.com/Ensembles/ert $WORKSPACE/deps/ert

  pushd .
  mkdir -p serial/build-ert
  cd serial/build-ert
  cmake $WORKSPACE/deps/ert/devel -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$WORKSPACE/serial/install
  make install
  popd

  # Build opm-common
  pushd .
  mkdir -p $WORKSPACE/deps/opm-common
  cd $WORKSPACE/deps/opm-common
  git init .
  git remote add origin https://github.com/akva2/opm-common
  git fetch origin $OPM_COMMON_REVISION:branch_to_build
  test $? -eq 0 || exit 1
  git checkout branch_to_build
  popd
  source $WORKSPACE/deps/opm-common/jenkins/build-opm-module.sh

  pushd .
  mkdir serial/build-opm-common
  cd serial/build-opm-common
  build_module "-DCMAKE_INSTALL_PREFIX=$WORKSPACE/serial/install" 0 $WORKSPACE/deps/opm-common
  popd

  # Build opm-parser
  git checkout $OPM_PARSER_REVISION
  pushd .
  mkdir serial/build-opm-parser
  cd serial/build-opm-parser
  build_module "-DCMAKE_PREFIX_PATH=$WORKSPACE/serial/install" 1 $WORKSPACE
  popd
}
