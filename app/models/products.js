/**
 * Arquivo models/products.js
 * Descrição: Responsável pelo CRUD da classe product
 */

const moment = require('moment')
const conexao = require('../infraestrutura/conexao')

class product {

    adiciona(products, res) {
        const created = moment().format('YYYY-MM-DD')
        const last_updated = moment().format('YYYY-MM-DD')
        const productCreated = {...products, created, last_updated}

        const sql = 'INSERT INTO product SET ?'
            
        conexao.query(sql, [productCreated], (erro, resultados) => {
            if(erro) {
                res.status(400).json(erro)
            } else {
                res.status(201).json(products)
            }
        })

    }
    lista(res) {
        const sql = 'SELECT * FROM product'

        conexao.query(sql, (erro, resultados) => {
            if(erro) {
                res.status(400).json(erro)
            } else {
                res.status(200).json(resultados)
            }
        })
    }

    buscaPorId(productId, res) {
        const sql = 'SELECT * FROM product WHERE product_id= ?'

        conexao.query(sql, [productId], (erro, resultados) => {
            const product = resultados[0]
            if(erro) {
                res.status(400).json(erro)
            } else {
                res.status(200).json(product)
            }
        })
    }

    altera(productId, valores, res) {
        const last_updated = moment().format('YYYY-MM-DD')
        //const productChange = {...valores, last_updated}
        const productChange = {...valores, last_updated}

        const sql = 'UPDATE product SET ? WHERE product_id= ?'
    
        conexao.query(sql, [productChange, productId], (erro, resultados) => {
            if(erro) {
                res.status(400).json(erro)
            } else {
                res.status(200).json({...valores, productId})
            }
       })
    }

    deleta(productId, res) {
        const sql = 'DELETE FROM product WHERE product_id= ?'

        conexao.query(sql, [productId], (erro, resultados) => {
            if(erro) {
                res.status(400).json(erro)
            } else {
                res.status(200).json({productId})
            }
        })
    }
}

module.exports = new product