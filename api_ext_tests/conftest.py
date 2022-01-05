# content of conftest.py
import pytest


def pytest_addoption(parser):
    parser.addoption(
        "--cmdopt", action="store", default="http://localhost:5000/api/v1", help="API url. Default http://localhost:5000/api/v1"
    )


@pytest.fixture
def cmdopt(request):
    return request.config.getoption("--cmdopt")