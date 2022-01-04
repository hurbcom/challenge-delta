import pytest
import requests

def test_get_all(cmdopt):
  header = {
    "Accept": "*/*",
    "User-Agent": "request"
  }

  url = cmdopt + "/todo"

  response = requests.get(url,headers=header)
  status = response.status_code

  if status == 200:
    data = response.json()
    todoCount = len(data["todos"])
    assert todoCount >= 0, "todo count %d is not greater or equal than 0" % todoCount
  else:
    assert False, "status code %d is not 200" % status

if __name__ == '__main__':
    pytest.main()
