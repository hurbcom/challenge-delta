# app

## Migrations

```bash
# Create Sequelize files
npx sequelize-cli init

# Create database
npx sequelize-cli db:create

# Create table
npx sequelize-cli model:generate \
    --name offer \
    --attributes Id:integer,Text:string,CreateDate:date

# Run migration
npx sequelize-cli db:migrate
