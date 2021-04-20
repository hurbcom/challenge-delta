const ProductsDAO = require('../model/Products.js');

class Products{
    constructor(options){
        this.productDAO = new ProductsDAO();
        if(options) this.options = options;
    }

    formatReturn(data, status){
        if(this.options.htmlResponse && !status) throw new Error("If options.htmlResponse is true, then must be sent a HTTP Status Code.")
        return this.options.htmlResponse ? { status, response: data } : data;
    }

    showProducts(params = {}){
        const options = [];
        options.push({ standard: { start: parseInt(params.start) || 0, num: parseInt(params.num) || 0 } });

        params.sku ? options.push({ sku: params.sku }) : null;
        params.barcode ? options.push({ barcode: params.barcode }) : null;
        params.fields ? options.push({ fields: params.fields }) : null;

        let productList = this.productDAO.getList(options);
        return this.formatReturn({ totalCount: productList.length, items: productList }, 200);
    }

    showById(id, params = {}){
        let { fields } = params;
        let product = this.productDAO.getById(id, fields);
        return this.formatReturn(product, 200);
    }
}

module.exports = Products;