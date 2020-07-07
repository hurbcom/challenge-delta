var restify = require('restify');
var errors = require('restify-errors');
var mysql = require('mysql');

var port = process.env.NODEJS_API_PORT;
if (!port) {
    port = 8888;
}

// conexao com o banco
var connection = mysql.createConnection({
    host: '192.168.15.12',
    port: '3306',
    user: 'app',
    password: 'senhaDB',
    database: 'packages',
    insecureAuth : true
});

var server = restify.createServer();

server.use(restify.plugins.bodyParser());

// get all packages
server.get('/packages', function (request, response, next) {
    connection.query('SELECT * FROM offer ORDER BY Id DESC', function (error, results, fields) {
        if (error) { next(error); return; }
        response.end(JSON.stringify(results));
    });
});

// create packages
server.post('/create', function (request, response, next) {
    if(!request.body) { return next(new errors.BadRequestError("texto inválido")); }
    connection.query('insert into packages.offer (Text) VALUES ("?")' , [request.body], function (error, results, fields) {
        if (error) { next(error); return; }
        response.end("Ok");
    });
});

// delete packages
server.del('/delete/:id', function (request, response, next) {
    var id = request.params.id;
    
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
