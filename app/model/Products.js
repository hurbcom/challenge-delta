class Products{
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
