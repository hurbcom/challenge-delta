FROM ubuntu:latest
RUN apt update -y && apt upgrade -y
RUN apt install nginx -y && apt install git -y && apt install wget -y
RUN git clone https://github.com/henriquenogueira/desafio-challenge-delta.git /home/
RUN mv /home/configs/nginx/app.conf /etc/nginx/conf.d/app.conf
ENTRYPOINT service nginx start && /bin/bash
