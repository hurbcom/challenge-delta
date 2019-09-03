#!/bin/bash
ask()
{
    echo "The following text will be saved in Kubernetes secrets"
    echo "You need to set the following (Note that existing values WILL be overwritten)"
    echo
    read -s -p "DB root Password: " db_root_password
    echo
    read -p "Application DB Username: " db_username
    echo
    read -s -p "Application DB Password: " db_password
    if [[ -z "$db_root_password" ||  -z "$db_username" || -z "$db_password" ]]
    then
        echo "Fill all information"
        echo
        ask
    fi
}

create_secrets()
{     
    kubectl delete secret mysql-root-pass mysql-user-pass mysql-db-name 
    kubectl create secret generic mysql-root-pass --from-literal=password=$db_root_password && \
    kubectl create secret generic mysql-user-pass --from-literal=username=$db_username --from-literal=password=$db_password && \
    kubectl create secret generic mysql-db-name --from-literal=database=packages
}

deploy()
{
    for f in $(ls ./*/deploy/*.yml); do
        echo Running deploy for $f
        kubectl apply -f $f
        echo
    done
}

db_import()
{
    APP_POD=$(kubectl get pod -l app=nodejs-app-server -o jsonpath="{.items[0].metadata.name}")
    echo Trying to import database
    kubectl exec -i $APP_POD -- mysql -h nodejs-app-mysql -u $db_username -p$db_password packages <./application/nodejs/database_schema.sql && echo DB Imported    
    echo
}
case $1 in
    deploy)
        ask
        create_secrets
        deploy
        echo Waiting 60 seconds to MySQL warm-up before running db_import
        sleep 60
        echo
        db_import
		;;
    db_import)
        ask
        db_import
        ;;
    update)
		deploy
		;;
	*)
		echo "Invalid or no arguments given, valid are: deploy, db_import or update"
        ;;
esac
