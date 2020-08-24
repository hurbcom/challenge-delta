ARG IMAGE
FROM ${IMAGE}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY ./docker/mysql/database_schema.sql /docker-entrypoint-initdb.d
