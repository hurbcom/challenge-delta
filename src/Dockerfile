FROM node:12.18.3-slim

ARG NODEJS_API_PORT=8888
ENV NODEJS_API_PORT $NODEJS_API_PORT

RUN apt-get update \
    && apt-get install -y python make

RUN mkdir -p /app \
    && chown node /app

WORKDIR /app

USER node
COPY package.json package-lock.json* ./
RUN npm install

COPY . .

EXPOSE $NODEJS_API_PORT

CMD ["node", "server.js"]