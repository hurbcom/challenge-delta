require('dotenv').config()

var restify = require('restify');
var errors = require('restify-errors');
var mysql = require('mysql');

var port = process.env.NODEJS_API_PORT;
if (!port) {
    port = process.env.SERVER_PORT;
}
var connection = mysql.createConnection({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASS
});

function respond(req, res, next) {
    res.send('hello ' + req.params.name);
    next();
}

var server = restify.createServer();
server.get('/hello/:name', respond);


var server = restify.createServer();

server.use(restify.plugins.bodyParser());

// Add CORS support
// Require after Restify upgrade to 8.x
const corsMiddleware = require('restify-cors-middleware')
const cors = corsMiddleware({
  origins: ['*'],
  allowHeaders: ['*'],
  exposeHeaders: ['*']
})
server.pre(cors.preflight)
server.use(cors.actual)

// get all packages
server.get('/packages/', function (request, response, next) {
    connection.query('select * from packages.offers order by Id desc', function (error, results, fields) {
        if (error) { next(error); return; }
        response.end(JSON.stringify(results));
    });
});

// create packages
server.post('/packages/', function (request, response, next) {
    if(!request.body) { return next(new errors.BadRequestError("texto inválido")); }
    connection.query('insert into packages.offers (Text) values ("?")', [request._body], function (error, results, fields) {
        if (error) { next(error); return; }
        response.end("Ok");
    });
});

// delete packages
server.del('/packages/:id', function (request, response, next) {
    var id = request.params.id;
    
    if(!id || id <= 0) { return next(new errors.BadRequestError("id inválido")); }
    
    connection.query('delete from packages.offers WHERE Id=?', [id], function (error, results, fields) {
        if (error) { next(error); return; }
        if(!results.affectedRows) { next(new errors.BadRequestError("id inválido")); return; }
        response.end("Ok");
    });
});

server.listen(port, function () {
    console.log('%s listening at %s', server.name, server.url);
});

module.exports = server;
