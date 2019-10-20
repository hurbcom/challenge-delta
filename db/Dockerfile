FROM mysql:5.7

COPY ./scripts/database_schema.sql docker-entrypoint-initdb.d/

EXPOSE 3306