ARG IMAGE
FROM ${IMAGE}

COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf

RUN ln -sf /var/log/nginx/access.log /dev/stdout \
    && ln -sf  /var/log/nginx/error.log /dev/stderr \
