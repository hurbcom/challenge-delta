const ProductBLL = require('../controller/Products');
const basicOptionsToApi = { htmlResponse: true };

const internalError = (er, res) => {
    console.log(er);
    res.status(500).json({ errorText: "The server has an error!" })
}

module.exports = server => {
    server.get('/api/products', (req, res) => {
        try{
            const product = new ProductBLL(basicOptionsToApi);
            let productsList = product.showProducts(req.query);
            res.status(productsList.status).json(productsList.response);
        }catch(er){
            internalError(er, res);
        }
    });
    
    server.get('/api/products/:productId', (req, res) => {
        try{
            const product = new ProductBLL(basicOptionsToApi);
            let productById = product.showById(req.params, req.query);
            res.status(productById.status).json(productById.response);
        }catch(er){}

        // let { body, params, query } = req;
        // console.log({ body, params, query });
        // res.status(200).json({ ok: true, http: 'OK' });
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