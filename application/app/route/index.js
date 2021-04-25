const ProductBLL = require('../controller/Products');
const basicOptionsToBLL = { htmlResponse: true };

const internalError = (er, res) => {
    console.log(er);
    res.status(500).json({ errorText: "The server has an error! Try again later." })
}

module.exports = server => {
    server.get('/api/products', async (req, res) => {
        try{
            const product = new ProductBLL(basicOptionsToBLL);
            let productsList = await product.showProducts(req.query);
            res.status(productsList.status).json(productsList.response);
        }catch(er){
            internalError(er, res);
        }
    });
    
    server.get('/api/products/:productId', (req, res) => {
        try{
            const product = new ProductBLL(basicOptionsToBLL);
            let productById = product.showById(req.params.productId, req.query);
            res.status(productById.status).json(productById.response);
        }catch(er){
            internalError(er, res);
        }
    });
    
    server.post('/api/products', (req, res) => {
        try{
            const product = new ProductBLL(basicOptionsToBLL);
            let addProduct = product.addProduct(req.body);
            res.status(addProduct.status).json(addProduct.response);
        }catch(er){
            internalError(er, res);
        }
    });
    
    server.put('/api/products/:productId', (req, res) => {
        try{
            const product = new ProductBLL(basicOptionsToBLL);
            let updProduct = product.updateProduct(req.params.productId, req.body);
            res.status(updProduct.status).json(updProduct.response);
        }catch(er){
            internalError(er, res);
        }
    });
    
    server.delete('/api/products/:productId', (req, res) => {
        try{
            const product = new ProductBLL(basicOptionsToBLL);
            let delProduct = product.deleteProduct(req.params.productId);
            res.status(delProduct.status).json(delProduct.response);
        }catch(er){
            internalError(er, res);
        }
    });
}