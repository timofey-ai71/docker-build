from fastapi import APIRouter

from docker_build.models.dummy import DummyResponse

router = APIRouter()


@router.get("/{id}", response_model=DummyResponse)
async def dummy_handle(id: int):
    """Dummy api handle."""
    print(f"Got request: {id}")

    return DummyResponse(
        status="success",
        id=id,
    )
