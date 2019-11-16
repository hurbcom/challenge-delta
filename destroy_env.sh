#sh
read -p "Os dados do banco de dados(Mysql) serão destruidos, pressione Enter para continuar:" 
echo "Destruindo Ambiente"
docker-compose -f ./env/docker-compose.yaml down
echo "Excluindo dados do Banco Mysql"
rm -rf ./env/db/mysql
echo "Ambiente Destruido"