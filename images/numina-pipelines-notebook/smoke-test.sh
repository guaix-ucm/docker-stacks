#!/bin/bash
# Run inside the container by CI after building the image
set -euo pipefail
python -c "import emirdrp, megaradrp; print('pyemir', emirdrp.__version__, 'megaradrp', megaradrp.__version__)"
# numina only warns when a pipeline fails to load, so check that all are listed
out=$(numina show-instruments 2>&1)
echo "$out"
for inst in EMIR MEGARA; do
    grep -q "^Instrument: $inst$" <<< "$out" || { echo "ERROR: pipeline $inst not loaded" >&2; exit 1; }
done
