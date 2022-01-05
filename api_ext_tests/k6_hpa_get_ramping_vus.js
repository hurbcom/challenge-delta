import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  discardResponseBodies: true,
  scenarios: {
    todos: {
      executor: 'ramping-vus',
      startVUs: 20,
      stages: [
        { duration: '20s', target: 20 },
        { duration: '20s', target: 30 },
        { duration: '20s', target: 10 },
        { duration: '5s', target: 0 },
      ],
      gracefulRampDown: '10s',
    },
  },
};

export default function () {
  http.get(`${__ENV.API_URL}/api/v1/todo`);
  sleep(1);
}