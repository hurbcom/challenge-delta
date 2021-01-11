class tabelas {
    init(conexao) {
        this.conexao = conexao

        this.criarSchema()
    }

    criarSchema() {
        const sql = `
        create database IF NOT EXISTS hurb_test_assignment default character set utf8mb4 collate utf8mb4_unicode_ci;
          
        use hurb_test_assignment;
        
        CREATE TABLE IF NOT EXISTS product (
          product_id int UNSIGNED NOT NULL AUTO_INCREMENT,
          title varchar(32) NOT NULL,
          name varchar(16),
          sku varchar(32) NOT NULL,
          barcode varchar(32) NOT NULL,
          description varchar(1024),
          price decimal(12,2) NOT NULL DEFAULT 0.00,
          attributes varchar(32),
          created datetime NOT NULL,
          last_updated datetime,
          PRIMARY KEY (product_id),
          UNIQUE INDEX (sku ASC),
          INDEX (created),
          INDEX (last_updated)
        );
        `

        this.conexao.query(sql, erro => {
            if (erro) {
                console.log(erro)
            } else {
                console.log('Schema criada com sucesso')
            }
        })
    }
}

module.exports = new tabelas()