#!/bin/bash

set -ex

export NODE_ENV=production

# Create database config file
cat <<-JSON > config/config.json
{
  "production": {
    "username": "${MYSQL_USER}",
    "password": "${MYSQL_PASS}",
    "database": "packages",
    "host": "${MYSQL_HOST}",
    "dialect": "mysql"
  }
}
JSON

# Waiting database start
sleep 5

# Run migrations
npx sequelize-cli db:create
npx sequelize-cli db:migrate

# Start main application
node server.js
