FROM nginx:stable

# Delete existing configurations and create symlinks to permit see the logs in docker-compose logs 
RUN rm -f /etc/nginx/conf.d/default.conf && \
    rm -f  /usr/share/nginx/html/* && \
    unlink /var/log/nginx/access.log && \
    unlink /var/log/nginx/error.log && \
    ln -sf /dev/stdout /var/log/nginx/reverse-access.log  && \
    ln -sf /dev/stderr /var/log/nginx/reverse-error.log 

COPY ./conf/ /etc/nginx/conf.d/

COPY ./html/ /usr/share/nginx/html/

EXPOSE 80

CMD ["/bin/sh", "-c", "exec nginx -g 'daemon off;';"]
