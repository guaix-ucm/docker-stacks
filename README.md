# Jupyter Docker stacks

This repository contains Jupyter Docker images based on those provided by the Jupyter project.

The images can be used for interactive computing in a Jupyter Lab environment.

For reference you can check the Jupyter Docker Stack documentation in https://jupyter-docker-stacks.readthedocs.io/en/latest/

The contents of this repository are under the MIT license

## Images

| Image | Description |
|-------|-------------|
| [catarsis-notebook](images/catarsis-notebook) | Catarsis tools (astropy, astroquery, ipyaladin...) |
| [numina-pipelines-notebook](images/numina-pipelines-notebook) | GTC pipelines for EMIR and MEGARA |
| [rstan-notebook](images/rstan-notebook) | R with RStan |

The images are published in https://quay.io/organization/guaix-ucm

## Automatic builds

The images are built by GitHub Actions (`.github/workflows/build-images.yml`):

- On pull requests, the modified images are built and tested, but not pushed
- On pushes to `main`, the modified images are built, tested and pushed to quay.io
- A build can be launched by hand from the Actions tab, for one image or for all of them

Each image is tagged with `latest`, the build date (`YYYY-MM-DD`) and the
extra tags listed in `images/<image>/tags`, one per line. If
`images/<image>/smoke-test.sh` exists, it is run inside the image before pushing it.

Pushing requires the repository secrets `QUAY_USERNAME` and `QUAY_PASSWORD`,
the credentials of a quay.io robot account with write access to the repositories.

## Building locally

```
./build.sh <image> [--push]
```

builds the image with podman, using the same tags as the automatic builds.

## Adding a new image

Create a directory `images/<name>` with a `Containerfile`, and optionally a
`README.md`, `tags` and `smoke-test.sh`. The image is published as `quay.io/guaix-ucm/<name>`,
and the repository has to exist in quay.io with write access for the robot account.
