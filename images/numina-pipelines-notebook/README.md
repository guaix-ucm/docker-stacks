# Numina pipelines notebook for GTC

This image contains the pipelines for the instruments of the GTC 10m telescope EMIR and MEGARA. Other instruments may be added in the future.

## Versions
The pipelines included in the latest image are **pyemir 0.22.1** and **megaradrp 0.17**

## Examples

To run the image, in console:
```
docker run -p 10000:8888 quay.io/guaix-ucm/numina-pipelines-notebook:2025-07-12
```

The process starts in the console and we can access the Jupyter Lab instance pointing the browser to `localhost:10000`.
The value of the cookie can be obtained from the console.

The container runs in isolation, meaning that it can't access the user's filesystem. To access images in our disk we
can mount part of our filesystem inside the container. If we start the container from the directory 
where our images are located, this command will mount the directory inside the container, in the directory `work`

```
docker run -p 10000:8888 -v "${PWD}":/home/jovyan/work quay.io/guaix-ucm/numina-pipelines-notebook:2025-07-12
```

For more examples, check https://jupyter-docker-stacks.readthedocs.io/en/latest/
