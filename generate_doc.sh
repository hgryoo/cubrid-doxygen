#!/usr/bin/env bash
# Build the CUBRID API documentation site locally or in CI.
#
# Steps:
#   1. Ensure ./cubrid is a fresh clone (or fetch) of CUBRID/cubrid develop.
#   2. Run mkdocs build, which invokes Doxygen (via mkdoxy) on cubrid/src
#      and renders the result with MkDocs Material.
#   3. Copy the Doxygen warnings log into the rendered site so it shows up
#      under "Build Info → Doxygen Warnings".
#
# Outputs:
#   site/                   - the static HTML site (deploy this)
#   doxygen-output/xml/     - raw Doxygen XML (intermediate)
#   doxygen-output/warnings.log
#
# Environment overrides:
#   CUBRID_REPO   - upstream URL (default: https://github.com/CUBRID/cubrid.git)
#   CUBRID_REF    - branch / tag / sha (default: develop)
#   CUBRID_DIR    - local checkout directory (default: ./cubrid)

set -euo pipefail

CUBRID_REPO="${CUBRID_REPO:-https://github.com/CUBRID/cubrid.git}"
CUBRID_REF="${CUBRID_REF:-develop}"
CUBRID_DIR="${CUBRID_DIR:-cubrid}"

echo "==> Preparing CUBRID source at ${CUBRID_DIR} (ref=${CUBRID_REF})"
if [ -d "${CUBRID_DIR}/.git" ]; then
  git -C "${CUBRID_DIR}" fetch --depth 1 origin "${CUBRID_REF}"
  git -C "${CUBRID_DIR}" checkout -f FETCH_HEAD
else
  rm -rf "${CUBRID_DIR}"
  git clone --depth 1 --branch "${CUBRID_REF}" "${CUBRID_REPO}" "${CUBRID_DIR}"
fi

echo "==> Building documentation site with MkDocs + mkdoxy"
rm -rf doxygen-output site
mkdocs build --strict=false

if [ -f doxygen-output/warnings.log ]; then
  echo "==> Capturing Doxygen warnings"
  {
    echo "# Doxygen Warnings"
    echo
    echo "Captured from the most recent build."
    echo
    echo '```text'
    cat doxygen-output/warnings.log
    echo '```'
  } > docs/build/warnings.md
fi

echo "==> Done. Site is at: site/"
