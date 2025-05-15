# Docker build optimization examples

## Run the app

```bash
poetry run uvicorn src.app:app --host 0.0.0.0 --port 8000
```

## Build docker image

### For local mac

```bash
./docker_build.sh dummy linux/aarch64
```

### For our deployment infrastructure

```bash
./docker_build.sh dummy linux/amd64
```

## Run the app in docker

```bash
docker run --rm --interactive --tty --publish 8000:8000 <image_name>
```
