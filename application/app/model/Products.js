const { conn } = require('../../config/db');
const db = require('../../config/db');

class Products{
    async createConn(){
        try{
            const conn = await db.conn();
            return conn;
        }catch(e){
            console.log('CREATE CONNECTION ERROR IN DAO PRODUCT CLASS\n', e.message);
        }
    }
     
    async getList(options){
        console.log(options);
        const conn = await this.createConn();
        let sql_where = [], sql_select = [], sql_limit = [];
        options.map(data => {
            Object.keys(data).forEach(key => {
                if(key == 'fields'){
                    let field = data[key].split(',');
                    sql_select = field.map(f => {
                        console.log('Press F to respect', f);
                        return f == 'productId' ? 'product.product_id' : (f == 'barcode' ? 'product_barcode.barcode' : 'product.'+f);
                    });
                }else if(key == 'standard'){
                    sql_limit.push(`LIMIT ${data[key].num}`);
                    sql_where.push(`product.product_id > ${data[key].start}`);
                }else{
                    sql_where.push(`${key == 'productId' ? 'product.product_id' : 
                        (key == 'barcode' ? 'product_barcode.barcode' : 
                            (key == 'price' ? 'product_attribute.price' : 'product.'+key))}='${data[key]}'`);
                }
            });
        });
        const sql = `SELECT ${sql_select.length > 0 ? sql_select.join(', '):'*'} FROM product INNER JOIN product_barcode ON product.product_id=product_barcode.product_id INNER JOIN product_attribute ON product_barcode.product_id=product_attribute.product_id ${sql_where.length > 0 ? 'WHERE '+sql_where.join(' AND ') : ''} ${sql_limit[0]}`;
        console.log(sql);
        try{
            const [rows, fields] = await conn.execute(sql);
            conn.end();
            return rows;
            
        }catch(e){
            console.log("ERROR IN DAO PRODUCT CLASS\n", e.message);
        }
    }

    getById(id, fields){
        console.log(id, fields);
        return [];
    }

    async saveProduct(obj){
        const dataQuery1 = [obj.title, obj.sku, obj.description, parseFloat(obj.price)];
        try{
            const conn = await this.createConn();
            await conn.beginTransaction();
            const [firstQuery] = await conn.query('INSERT INTO product (title, sku, description, price) values(?, ?, ?, ?)', dataQuery1);
            const dataQuery2 = [obj.barcodes.map(code => [firstQuery.insertId, code])];
            await conn.query('INSERT INTO product_barcode (product_id, barcode) values ?', dataQuery2);
            
            const dataQuery3 = [obj.attributes.map(attr => [firstQuery.insertId, attr.name, attr.value])];
            await conn.query('INSERT INTO product_attribute (product_id, name, value) values ?', dataQuery3);
            
            await conn.commit();
            await conn.end();

            return firstQuery.insertId;
            
        }catch(e){
            console.log("ERROR IN DAO PRODUCT CLASS\n", e.message);
            return e.message;
        }
    }

    updateProduct(id, obj){
        return true;
    }

    deleteProduct(id){
        return true;
    }
}
module.exports = Products;
