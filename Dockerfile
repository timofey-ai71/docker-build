FROM python:3.12-slim

ARG POETRY_VERSION

RUN pip install poetry==$POETRY_VERSION

COPY . .

RUN poetry install

CMD ["poetry", "run", "uvicorn", "docker_build.app:app", "--host", "0.0.0.0", "--port", "8000"]
