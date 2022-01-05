import http from 'k6/http';
import { sleep } from 'k6';

export default function () {
  http.get(`${__ENV.API_URL}/api/v1/todo`);
  sleep(1);
}