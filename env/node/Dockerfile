FROM node:latest
RUN mkdir /src
WORKDIR /src
ADD package.json server.js ./
RUN npm install
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.2.1/wait /wait
RUN chmod +x /wait
CMD /wait && npm start