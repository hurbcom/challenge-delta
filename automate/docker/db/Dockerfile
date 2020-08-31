FROM mysql:5.7

COPY app/db/*.sql /docker-entrypoint-initdb.d

VOLUME /var/lib/mysql

EXPOSE 3306