FROM python:3.12-slim

RUN pip install poetry

COPY . .

RUN poetry install

CMD ["poetry", "run", "uvicorn", "docker_build.app:app", "--host", "0.0.0.0", "--port", "8000"]
