FROM node:14.15.4-alpine3.12
WORKDIR /app
COPY ./app/package*.json .
RUN npm install
COPY ./app .
EXPOSE 3000
CMD ["node", "index.js"]