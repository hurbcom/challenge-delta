FROM nginx:stable-alpine

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

ADD automate/docker/reverseproxy/hurb.conf.template /etc/nginx/templates/default.conf.template