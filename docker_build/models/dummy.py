from pydantic import BaseModel


class DummyResponse(BaseModel):
    status: str
    id: int
