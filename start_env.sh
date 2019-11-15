#sh
echo "Iniciando o ambiente"
docker-compose -f ./env/docker-compose.yaml up -d
echo "Ambiente Iniciado, se for a primeira vez aguarde 1 a 2 minutos para concluir a criação do banco de dados"