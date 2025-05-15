FROM python:3.12-slim AS builder

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


FROM python:3.12-slim AS runtime

ENV VIRTUAL_ENV=/app/.venv \
    PATH="/app/.venv/bin:$PATH" \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}
COPY docker_build ./docker_build

CMD ["uvicorn", "docker_build.app:app", "--host", "0.0.0.0", "--port", "8000"]
