#!/bin/bash
# Run inside the container by CI after building the image
set -euo pipefail
python -c "import astropy, astroquery, ipyaladin, pymysql, regions; print('astropy', astropy.__version__)"
