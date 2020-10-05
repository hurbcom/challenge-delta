FROM debian:stretch-slim
LABEL maintainer Leandro Moreira <leandro@leandromoreirati.com.br>

WORKDIR /opt/api

COPY . /opt/api/

RUN echo "deb http://ftp.de.debian.org/debian stretch main non-free" >> /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends python3-pip && \
    pip3 install -r /opt/api/requirements.txt -t . && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /etc/apache2/sites-enabled/* && \
    rm -rf /tmp/* 

RUN useradd -c "Service User" -s /bin/bashapi && \
    chown -R api.api /opt/api

CMD ["flask run"]