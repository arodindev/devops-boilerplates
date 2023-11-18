import pytest
from starlette.testclient import TestClient

from src.main import app


@pytest.fixture(scope="module")
def test_app():
    with TestClient(app) as _client:
        yield _client
