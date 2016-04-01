#!/bin/bash

git clean -xffd

source `dirname $0`/build-opm-parser.sh

OPM_COMMON_REVISION=master
OPM_PARSER_REVISION=$sha1
if grep -q "opm-common=" <<< $ghprbCommentBody
then
  OPM_COMMON_REVISION=pull/`echo $ghprbCommentBody | sed -r 's/.*opm-common=([0-9]+).*/\1/g'`/merge
fi

echo "Building with opm-common=$OPM_COMMON_REVISION opm-parser=$OPM_PARSER_REVISION"

build_opm_parser

cp serial/build-opm-parser/testoutput.xml .
