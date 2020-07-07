#Dockerfile criado para subir img do container de MySql Official
#SO = Debian | Excuta atulizacoes de SO e Upgrades Necessarios
FROM mysql:5.6
RUN apt update -y && apt upgrade -y
