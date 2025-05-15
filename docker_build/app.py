import os

from fastapi import FastAPI

from docker_build.api import dummy

app = FastAPI(
    title="Dummy API",
    root_path=os.getenv("FASTAPI_ROOT_PATH", "/"),
    root_path_in_servers=True,
)

app.include_router(dummy.router, prefix="/dummy", tags=["Dummy API"])
