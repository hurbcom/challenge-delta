const mysql = require('mysql')

const path = require('path')
require('dotenv').config({ 
    path: path.resolve('./env/.env') 
 })

const conexao = mysql.createConnection({
    host: process.env.HOST,
    port: process.env.PORT,
    user: process.env.USER,
    password: process.env.PASSWORD,
    multipleStatements: true // permitindo a execucao de multiplas querys de uma unica vez.
})

module.exports = conexao