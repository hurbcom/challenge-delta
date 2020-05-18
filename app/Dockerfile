FROM node:10

RUN mkdir -p /packages && chown -R node:node /packages

WORKDIR /packages

COPY package.json ./

run npm install

COPY server.js .

COPY --chown=node:node . .

USER node

EXPOSE 8888

CMD [ "node", "server.js" ]

