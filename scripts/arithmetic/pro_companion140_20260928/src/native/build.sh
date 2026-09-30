#!/bin/sh
set -eu
cd "$(dirname "$0")/../.."
mkdir -p work
g++ -std=c++20 -O3 -Wall -Wextra -Wno-misleading-indentation -DBOOST_BIND_GLOBAL_PLACEHOLDERS src/native/companion.cpp -o work/companion -lgmp
