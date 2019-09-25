#! /bin/bash
set +xe

# testa o verbo GET esperando po uma resposta diferente de 200.
test_apiGet()
{
    ok="200"
	responseGet=$(curl -s -o /dev/null -w "%{http_code}" $(minikube ip)/packages)
	if [ "$responseGet" != "$ok" ];then 
        echo "opa algo deu errado! Erro: "$responseGet""
	else 
        echo "resposta da api GET : "$responseGet", esta tudo certo."
	fi
}

# testa o verbo POST esperando po uma resposta diferente de Ok.
test_apiPost()
{
    ok="Ok"
	responsePost=$(curl -s -X POST $(minikube ip)/packages -d "teste")
	if [ "$responsePost" != "$ok" ];then 
        echo "opa algo deu errado! Erro: "$responsePost""
	else 
        echo "resposta da api POST : "$responsePost", esta tudo certo."
    fi
}

# testa o verbo DELETE esperando po uma resposta diferente de Ok.
# teste esta quebrando pois o nginx esta retornando method not allowed 405 para DELETE(???)
# funcionava antes de colocar regex para redirecionamento do path
test_apiDel()
{
    ok="Ok"
    responseGet=$(curl -s $(minikube ip)/packages)
	responseDel=$(curl -s -X DELETE $(minikube ip)/packages/$(curl -s $(minikube ip)/packages | grep "Id" | awk -F "," '{print $1}'| awk -F ":" '{print $2}'))
	if [ "$responseDel" != "$ok" ];then 
        echo "opa algo deu errado! Erro: "$responseDel""
	else 
        echo "resposta da api DELETE : "$responseDel", esta tudo certo."
    fi
}

test_apiGet
test_apiPost
test_apiDel