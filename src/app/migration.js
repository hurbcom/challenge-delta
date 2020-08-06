require('dotenv').config()

var Sequelize = require('sequelize')
var connection = new Sequelize(
    'myapp',
    process.env.MYSQL_USER,
    process.env.MYSQL_PASS,
    {
        host: process.env.MYSQL_HOST,
        dialect: 'mysql'
    }
    
)

var Artigos = connection.define('artigos', {
    titulo: Sequelize.STRING,
    assunto : Sequelize.TEXT
});

Artigos.sync()








// var mysql = require('mysql');

// var port = process.env.NODEJS_API_PORT;
// if (!port) {
//     port = process.env.SERVER_PORT;
// }
// var connection = mysql.createConnection({
//     host: process.env.MYSQL_HOST,
//     user: process.env.MYSQL_USER,
//     password: process.env.MYSQL_PASS
// });

// // Read SQL file
// var fs = require("fs");
// fs.readFile("database/database_schema.sql", function(err, buf) {
//     SQL_CONTENT=buf.toString()

//     // Run database schema
//     connection.query(SQL_CONTENT, function(err, results) {
//         if (err) throw err;

//         console.log("Migration executed:")
//         console.log(SQL_CONTENT)
//     });
// });
