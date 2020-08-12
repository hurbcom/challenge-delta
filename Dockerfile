FROM node:11.15.0-stretch-slim

WORKDIR /app
COPY package*.json ./
RUN apt-get update && apt-get install -y python make
RUN npm install
COPY . .
EXPOSE 8888
CMD ["npm", "run", "start"]