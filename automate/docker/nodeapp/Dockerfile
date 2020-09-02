FROM node:alpine

WORKDIR /usr/src/app

COPY app/src/package.json ./
COPY app/src/server.js ./

RUN npm install
RUN npm audit

EXPOSE 8888

CMD [ "node", "server.js" ]