ARG IMAGE
FROM ${IMAGE}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf

RUN ln -sf /var/log/nginx/access.log /dev/stdout \
    && ln -sf  /var/log/nginx/error.log /dev/stderr \
