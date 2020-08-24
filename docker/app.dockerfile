ARG IMAGE
FROM ${IMAGE}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN mkdir /app
WORKDIR /app

COPY ./src/package.json .

# There are packages with vulnerability. The commands below, in addition to installing the dependencies, correct them as recommendation.
RUN npm --version \
    && npm install \
    && npm fund \
    && npm audit fix --force \
    && npm install --force

COPY ./src/ .
RUN node server --version

CMD ["server"]
