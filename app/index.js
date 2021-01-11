/**
 * Arquivo app/index.js
 * Descrição: Responsável pela chamada da API da aplicação e criação das tabelas no banco de dados
 */

const customExpress = require('./config/customExpress')
const conexao = require('./infraestrutura/conexao')
const tabelas = require('./infraestrutura/tabelas')

conexao.connect(erro => {
    if(erro) {
        console.log(erro) //Caso a conexão com o banco falhe, a aplicação não irá subir.
    } else {
        console.log('Banco conectado com sucesso')
        
        tabelas.init(conexao)
        
        const app = customExpress()

        app.listen(3000, () => console.log('Servidor rodando na porta 3000'))
    }
})
