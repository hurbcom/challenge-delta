FROM node:12

WORKDIR /app

COPY . .

RUN set -x \
    && npm install

CMD [ "node", "./server.js" ]
