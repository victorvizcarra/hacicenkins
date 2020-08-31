#!/bin/bash -eo pipefail

set -e

(echo test  || exit 1) |  grep -i t

