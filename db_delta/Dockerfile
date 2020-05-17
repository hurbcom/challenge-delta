FROM mysql:5.7
 
ENV MYSQL_DATABASE="packages"
ENV MYSQL_USER="user_packages"
ENV MYSQL_PASSWORD="passwords"
ENV MYSQL_RANDOM_ROOT_PASSWORD="yes"

COPY ./files/*.sql /docker-entrypoint-initdb.d/

EXPOSE 3306