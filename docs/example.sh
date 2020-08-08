#!/bin/bash

# Setting up some colors for helping read the demo output.
# Comment out any of the below to turn off that color.
if [[ ${TERM} != "dumb" ]]; then
    bold=$(tput bold)
    reset=$(tput sgr0)

    red=$(tput setaf 1)
    green=$(tput setaf 2)
    yellow=$(tput setaf 3)
    blue=$(tput setaf 4)
    purple=$(tput setaf 5)
    cyan=$(tput setaf 6)
    white=$(tput setaf 7)
    grey=$(tput setaf 8)
    vivid_red=$(tput setaf 9)
    vivid_green=$(tput setaf 10)
    vivid_yellow=$(tput setaf 11)
    vivid_blue=$(tput setaf 12)
    vivid_purple=$(tput setaf 13)
    vivid_cyan=$(tput setaf 14)
fi

log() {
    if [[ $1 == *"["*"]"* ]]; then
        out=$(echo $1 | sed "s/]/]${reset}/g")
        echo "${bold}$out${reset}"
    else
        echo "${bold}$1${reset}"
    fi
}

log_bold() {
    echo "${bold}$1${reset}"
}

log_info() {
    if [[ $1 == *"["*"]"* ]]; then
        out=$(echo $1 | sed "s/]/]${reset}/g")
        echo "${vivid_purple}$out${reset}"
    else
        echo "${cyan}$1${reset}"
    fi
}

log_warning() {
    echo "${vivid_yellow}$1${reset}"
}

log_error() {
    echo "${vivid_red}$1${reset}"
}

cd ..

log_info "# Construa as imagens"
echo "$ docker-compose build"
sleep 2
docker-compose build
echo 

log_info "# Execute os containers"
echo "$ docker-compose up -d"
docker-compose up -d
echo
sleep 1

log_info "# Aguarde os containers iniciarem"
printf "Iniciando"
for i in {1..5}
do
   printf "."
   sleep 2
done
echo
echo
sleep 1

log_info "# Adicionar 'offer'"
echo "${vivid_blue}[request]${reset} $ curl ${vivid_green}-X POST${reset} \\"
echo '    -H "Content-Type: application/x-www-form-urlencoded" \'
echo "    ${vivid_yellow}-d \"Watch Dogs 2\"${reset} \\"
echo '    http://localhost:3000/packages/'
echo "${vivid_green}[response]${reset} $(curl -s -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "Watch Dogs 2" http://localhost:3000/packages/)"
echo
sleep 2

log_info "# Listar 'offers'"
echo "${vivid_blue}[request]${reset} $ curl http://localhost:3000/packages/"
echo "${vivid_green}[response]${reset} $(curl -s http://localhost:3000/packages/)"
echo
sleep 2

log_info "# Remover 'offer'"
echo "${vivid_blue}[request]${reset} $ curl ${vivid_red}-X DELETE${reset} http://localhost:3000/packages/1"
echo "${vivid_green}[response]${reset} $(curl -s -X DELETE http://localhost:3000/packages/1)"
echo
sleep 2

log_info "# Listar 'offers'"
echo "${vivid_blue}[request]${reset} $ curl http://localhost:3000/packages/"
echo "${vivid_green}[response]${reset} $(curl -s http://localhost:3000/packages/)"
echo
sleep 1

log_info "# Bye :)"


sleep 10
echo "# Byebye"
