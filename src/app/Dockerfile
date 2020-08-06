FROM node:12

WORKDIR /app

RUN npm install -g npx

COPY . .

RUN set -x \
    && npm install \
    && chmod +x entrypoint.sh

# TODO use another user

ENV SERVER_PORT=8888

EXPOSE 8888

CMD [ "/app/entrypoint.sh" ]
