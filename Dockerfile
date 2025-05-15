FROM python:3.12-slim

ARG POETRY_VERSION
RUN pip install poetry==$POETRY_VERSION

WORKDIR /app

COPY pyproject.toml poetry.lock ./
COPY docker_build ./docker_build
# Quirk of poetry, we will get rid of it later
RUN touch README.md

RUN poetry install

CMD ["poetry", "run", "uvicorn", "docker_build.app:app", "--host", "0.0.0.0", "--port", "8000"]
