set -eo pipefail

set -x

f_database_populate () {
  pushd $(dirname $PWD/mysql/db)

  export MYSQLPOD=$(kubectl get pods -n mysql -l app=mysql --no-headers | awk '{print $1}')
  MYSQL_SQL_FILE="db/database.sql"
  MYSQL_USERNAME=$(kubectl get secret -n mysql mysql-secrets -o jsonpath='{.data.mysql-user}' | base64 --decode -)
  MYSQL_PASSWORD=$(kubectl get secret -n mysql mysql-secrets -o jsonpath='{.data.mysql-password}' | base64 --decode -)
  MYSQL_DATABASE=$(kubectl get secret -n mysql mysql-secrets -o jsonpath='{.data.mysql-database}' | base64 --decode -)

  kubectl exec -n mysql -i $MYSQLPOD -- mysql --user=$MYSQL_USERNAME --password=$MYSQL_PASSWORD $MYSQL_DATABASE < $MYSQL_SQL_FILE
} 

f_database_deployment () {
  kubectl apply -f mysql/mysql.yml
}

f_database_delete () {
  kubectl delete -f mysql/mysql.yml
}

f_build_container () {
  docker build --rm --no-cache -t leandromoreirajfa/api:latest -f api/Dockerfile .
}

f_build_push () {
  docker login
  docker push leandromoreirajfa/api:latest
}

f_application_deployment () {
  kubectl apply -f api/app.yml
}

f_application_delete () {
  kubectl delete -f api/app.yml
}

case $1 in 
  database-populate)
    f_database_populate
  ;;

  database-deploy)
    f_database_deployment
  ;;

  database-delete)
    f_database_delete
  ;;
  build-container)
    f_build_container
    f_build_push
  ;;
  application-deploy)
    f_application_deployment
  ;;
  deploy)
    f_database_deployment
    f_application_deployment
  ;;
  destroy)
    f_database_delete
    f_application_delete
  ;;

  *)

    echo "Usage: deploy|destroy|application-deploy|build-container|database-deploy|database-populate|database-delete"
    exit 0
  ;;

esac