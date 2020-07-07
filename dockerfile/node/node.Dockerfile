FROM ubuntu:latest
RUN apt update -y && apt upgrade -y
RUN apt install nodejs -y && apt install npm -y && npm install restify -y && npm install mysql -y && apt install git -y && apt install wget -y
RUN git clone https://github.com/henriquenogueira/desafio-challenge-delta.git /home/
RUN sed -i 's/senhaDB/senha.123/g' /home/configs/node/server.js
ENTRYPOINT node /home/configs/node/server.js && /bin/bash
