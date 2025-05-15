FROM python:3.12-slim

RUN apt-get update && apt-get install -y curl --no-install-recommends --no-install-suggests
RUN curl -fsSL https://install.python-poetry.org | python3 -
RUN apt-get purge -y curl && rm -rf /var/lib/apt/lists/*

COPY . .

ENV PATH="/root/.local/bin:$PATH"

RUN poetry install

CMD ["poetry", "run", "uvicorn", "docker_build.app:app", "--host", "0.0.0.0", "--port", "8000"]
