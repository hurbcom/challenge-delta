ARG IMAGE
FROM ${IMAGE}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN mkdir /app
WORKDIR /app

COPY ./src/package.json .

# Existem pacotes com vulnerabilidade. Os comandos abaixo, além de instalar as dependências, os corrigem conforme
# recomendação.

RUN npm --version \
    && npm install \
    && npm fund \
    && npm audit fix --force \
    && npm install --force

COPY ./src/ .
RUN node server --version

CMD ["server"]
