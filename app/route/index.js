module.exports = server => {
    server.get('/api/products', (req, res) => {
        let { body, params, query } = req;
        console.log({ body, params, query });
        res.status(200).json({ ok: true, http: 'OK' });
    });
    
    server.get('/api/products/:productId', (req, res) => {
        let { body, params, query } = req;
        console.log({ body, params, query });
        res.status(200).json({ ok: true, http: 'OK' });
    });
    
    server.post('/api/products', (req, res) => {
        let { body, params, query } = req;
        console.log({ body, params, query });
        res.status(201).json({ ok: true, http: 'Created' });
    });
    
    server.put('/api/products/:productId', (req, res) => {
        let { body, params, query } = req;
        console.log({ body, params, query });
        res.status(200).json({ ok: true, http: 'Ok' });
    });
    
    server.delete('/api/products/:productId', (req, res) => {
        let { body, params, query } = req;
        console.log({ body, params, query });
        res.status(200).json({ ok: true, http: 'Ok' });
    });
}