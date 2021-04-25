const db = require('../../config/db');

class Products{
    
    async test(){
        try{
            const conn = await db.conn();
            const [rows, fields] = await conn.execute('SELECT * FROM product');
            console.log("===== ROWS =====")
            console.log(rows)
            console.log("===== FIELDS =====")
            console.log(fields)
            
        }catch(er){
            console.log("MODEL ERROR", er.message);
        }
    }
     
    getList(options){
        console.log(options);
        return [];
    }

    getById(id, fields){
        console.log(id, fields);
        return [];
    }

    saveProduct(obj){
        console.log(obj);
        return 0;
    }

    updateProduct(id, obj){
        return true;
    }

    deleteProduct(id){
        return true;
    }
}
module.exports = Products;
