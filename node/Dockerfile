FROM node:14-alpine as builder

RUN apk add --no-cache python make g++

WORKDIR /home/node/app

ADD ./FILES .
RUN npm install

FROM node:14-alpine

WORKDIR /home/node/app
COPY --from=builder /home/node/app/ .

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.7.2/wait /wait
RUN chmod +x /wait

CMD /wait && npm start