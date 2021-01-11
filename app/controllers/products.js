/**
 * Arquivo controllers/products.js
 * Descrição: Responsável pelas rotas da API relacionado pela classe product
 */

const product = require('../models/products')

module.exports = app => {
    app.get('/api/products', (req, res) => {
        product.lista(res)
    })

    app.get('/api/products/:productId', (req, res) => {
        const productId = parseInt(req.params.productId)

        product.buscaPorId(productId, res)
    })

    app.post('/api/products', (req, res) => {
       const products = req.body

       product.adiciona(products, res)
    }) 

    app.put('/api/products/:productId', (req, res) => {
        const productId = parseInt(req.params.productId)
        const valores = req.body

        product.altera(productId, valores, res)
    })

    app.delete('/api/products/:productId', (req, res) => {
        const productId = parseInt(req.params.productId)

        product.deleta(productId, res)
    })
}