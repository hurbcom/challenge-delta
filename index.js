const server = require('./config/server.js');
const { API_PORT } = require('./config/consts.js');

const routes = require('./app/route');
routes(server);
server.use((req, res) => res.json(404).json({ errorText: "Page not found." }));

server.listen(API_PORT, er => console.log(er || `Server on port ${API_PORT}`))