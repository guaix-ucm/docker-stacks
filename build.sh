#!/bin/bash
# Build a container image locally
#
# Usage: ./build.sh <image> [--push]
#   <image>  directory name under images/
#   --push   push all tags to the registry after building
#
# Tags: latest, the build date (YYYY-MM-DD) and the extra tags listed
# in images/<image>/tags, one per line. The GitHub Actions workflow
# uses the same convention.

set -euo pipefail

usage() {
    echo "Usage: $0 <image> [--push]" >&2
    echo "Available images:" >&2
    find "$TOP/images" -mindepth 2 -maxdepth 2 -name Containerfile -printf '  %h\n' \
        | xargs -n1 basename | sort >&2
    exit 1
}

TOP=$(cd "$(dirname "$0")" && pwd)
IMAGE_DESC="${1:-}"
PUSH="${2:-}"
IMAGE_DIR="$TOP/images/$IMAGE_DESC"

[[ -n "$IMAGE_DESC" && -f "$IMAGE_DIR/Containerfile" ]] || usage

# Get current date and git commit hash
BUILD_DATE=$(date -Iseconds)
BUILD_DATE_SHORT=$(date +%F)
VCS_REF=$(git -C "$TOP" rev-parse --short HEAD)

BASE_REG_ID="quay.io/guaix-ucm"
IMAGE_NAME="$BASE_REG_ID/$IMAGE_DESC"

TAGS=(latest "$BUILD_DATE_SHORT")
if [[ -f "$IMAGE_DIR/tags" ]]; then
    while read -r tag; do
        [[ -z "$tag" || "$tag" == \#* ]] && continue
        TAGS+=("$tag")
    done < "$IMAGE_DIR/tags"
fi

TAG_ARGS=()
for tag in "${TAGS[@]}"; do
    TAG_ARGS+=(-t "$IMAGE_NAME:$tag")
done

# Build the image with labels
podman build --format docker \
    --build-arg BUILD_DATE="$BUILD_DATE" \
    --build-arg VCS_REF="$VCS_REF" \
    "${TAG_ARGS[@]}" \
    "$IMAGE_DIR"

if [[ "$PUSH" == "--push" ]]; then
    for tag in "${TAGS[@]}"; do
        podman push "$IMAGE_NAME:$tag"
    done
fi
