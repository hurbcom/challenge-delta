from node

RUN mkdir -p /opt/hurbapp
WORKDIR /opt/hurbapp

COPY server.js package.json /opt/hurbapp/

RUN npm install restify
RUN npm install restify-errors
RUN npm install mysql

ENTRYPOINT ["node"]

CMD ["server.js"]
