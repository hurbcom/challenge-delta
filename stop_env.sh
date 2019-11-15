#sh
echo "Encerrando o ambiente"
docker-compose -f ./env/docker-compose.yaml down
echo "Ambiente encerrado os dados do MySQL foram preservados"