FROM node:alpine

WORKDIR /usr/src/app

COPY app/src/package.json ./
COPY app/src/server.js ./

RUN npm install

EXPOSE 8888

CMD [ "node", "server.js" ]