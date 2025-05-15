FROM python:3.12-slim

ARG POETRY_VERSION
RUN pip install poetry==$POETRY_VERSION

ENV POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

WORKDIR /app

COPY pyproject.toml poetry.lock ./

RUN <<EOF
poetry install \
  --without dev \
  --no-root \
  --no-interaction
rm -rf $POETRY_CACHE_DIR
EOF

COPY docker_build ./docker_build

CMD ["poetry", "run", "uvicorn", "docker_build.app:app", "--host", "0.0.0.0", "--port", "8000"]
