#!/bin/bash

set -ex

# Waiting database start
sleep 5

# Run migrations
npx sequelize-cli db:create
node migration.js

# Start main application
node server.js
