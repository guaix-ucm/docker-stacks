# Catarsis notebook

This image contains tools for the Catarsis project in Jupyter Lab: astropy, astroquery,
ipyaladin, pymysql and regions.

## Versions
The versions of the packages are pinned in `requirements.txt`

## Examples

To run the image, in console:
```
docker run -p 10000:8888 quay.io/guaix-ucm/catarsis-notebook:latest
```

The process starts in the console and we can access the Jupyter Lab instance pointing the browser to `localhost:10000`.
The value of the cookie can be obtained from the console.

The container runs in isolation, meaning that it can't access the user's filesystem. To access files in our disk we
can mount part of our filesystem inside the container. If we start the container from the directory
where our files are located, this command will mount the directory inside the container, in the directory `work`

```
docker run -p 10000:8888 -v "${PWD}":/home/jovyan/work quay.io/guaix-ucm/catarsis-notebook:latest
```

For more examples, check https://jupyter-docker-stacks.readthedocs.io/en/latest/
