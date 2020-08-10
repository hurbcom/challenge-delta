FROM mysql:5.7

COPY database_schema.sql /docker-entrypoint-initdb.d

ENV MYSQL_ROOT_PASSWORD="123@qwe"
ENV MYSQL_DATABASE="packages"
ENV MYSQL_USER="user_packages"
ENV MYSQL_PASSWORD="passwords"
