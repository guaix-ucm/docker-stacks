#!/bin/bash
# Run inside the container by CI after building the image
set -euo pipefail
Rscript -e 'library(rstan); cat("rstan", as.character(packageVersion("rstan")), "\n")'
