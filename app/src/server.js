const restify = require('restify');
const errors = require('restify-errors');
const mysql = require('mysql');
const port = process.env.NODEJS_API_PORT || '8888';
const dbUrl = process.env.MYSQL_URL || 'db';
const dbUsername = process.env.MYSQL_USER || 'user_packages';
const dbPassword = process.env.MYSQL_PASSWORD || 'passwords';

const connection = mysql.createConnection({
    host: dbUrl,
    user: dbUsername,
    password: dbPassword
});

const server = restify.createServer();

server.use(restify.plugins.bodyParser());

// get all packages
server.get('/packages', function (request, response, next) {
    connection.query('select * from packages.offer order by Id desc', function (error, results, fields) {
        if (error) { next(error); return; }
        response.end(JSON.stringify(results));
    });
});

// create packages
server.post('/packages', function (request, response, next) {
    if(!request.body) { return next(new errors.BadRequestError("texto inválido")); }
    connection.query('insert into packages.offer (Text) values ("?")', [request.body], function (error, results, fields) {
        if (error) { next(error); return; }
        response.end("Ok");
    });
});

// delete packages
server.del('/packages/:id', function (request, response, next) {
    const id = request.params.id;
    
    if(!id || id <= 0) { return next(new errors.BadRequestError("id inválido")); }
    
    connection.query('delete from packages.offer WHERE Id=?', [id], function (error, results, fields) {
        if (error) { next(error); return; }
        if(!results.affectedRows) { next(new errors.BadRequestError("id inválido")); return; }
        response.end("Ok");
    });
});

server.listen(port, function () {
    console.log('%s listening at %s', server.name, server.url);
});

module.exports = server;
