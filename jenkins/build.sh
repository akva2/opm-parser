#!/bin/bash

git clean -xffd

source `dirname $0`/build-opm-parser.sh

OPM_COMMON_REVISION=master
OPM_PARSER_REVISION=master

build_opm_parser

cp serial/build-opm-parser/testoutput.xml .
