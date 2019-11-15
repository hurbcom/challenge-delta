FROM node
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY --chown=node:node package.json server.js ./
RUN npm install
USER node
EXPOSE 8888
CMD [ "node", "server.js" ]