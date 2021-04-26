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
        return 0;
        const post_product = [obj.title, obj.sku, obj.description, parseFloat(obj.price)];
        let attr_values = (prodId) => obj.attributes.map(attr => `(${prodId}, '${attr.name}', '${attr.value}')`);
        try{
            const conn = await this.createConn();
            console.log("INSERT INTO product (title, sku, description, price) values(?, ?, ?, ?)")
            let [rows1, fields1] = await conn.execute('INSERT INTO product (title, sku, description, price) values(?, ?, ?, ?)', post_product);
            console.log("INSERT INTO product_barcode (product_id, barcode) values(?, ?)")
            let [rows2, fields2] = await conn.execute('INSERT INTO product_barcode (product_id, barcode) values(?, ?)', [rows1.insertId, obj.barcode]);
            console.log(`INSERT INTO product_attribute (product_id, name, value) values${attr_values(rows1.insertId).join(',')}`)
            let [rows3, fields3] = await conn.execute(`INSERT INTO product_attribute (product_id, name, value) values${attr_values(rows1.insertId).join(',')}`);

            // const [rows, fields] = await conn.execute('INSERT INTO product (title, sku, description, price) values(?, ?, ?)', post_product);
            return rows.insertId;
            
        }catch(e){
            console.log("ERROR IN DAO PRODUCT CLASS\n", e.message);
            await conn.rollback();
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
