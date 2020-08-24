ARG IMAGE
FROM ${IMAGE}

COPY ./docker/mysql/database_schema.sql /docker-entrypoint-initdb.d
