FROM node:alpine

WORKDIR /home/appdelta

COPY ./files/package*.json ./

RUN npm install --silent

COPY ./files/* ./

EXPOSE 8888

ENTRYPOINT ["node", "server.js"]