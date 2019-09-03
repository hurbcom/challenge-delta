# Pinned version to avoid misbehaviour in future implementation
FROM node:12.9.1-alpine
RUN mkdir -p /opt/app 
WORKDIR /opt/app
ADD server.js ./
ADD package.json ./
ADD database_schema.sql ./
# Some NPM packages needs python and make, so temp install it
RUN apk add --no-cache mysql-client make gcc g++ python && \
  npm install --silent && \
  apk del make gcc g++ python
CMD ["npm", "start"]