FROM node:8.12.0
RUN mkdir -p /opt/nodejs
ADD package.json /opt/nodejs
ADD server.js /opt/nodejs
WORKDIR /opt/nodejs
RUN npm install
EXPOSE 3000
CMD ["npm", "run", "start"]
ADD . /opt/nodejs