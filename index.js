const server = require('./config/server.js');
const { API_PORT } = require('./config/consts.js');

const routes = require('./app/route');
routes(server);

server.listen(API_PORT, er => console.log(er || `Server on port ${API_PORT}`))