
## CRIAR PACKAGE
curl -XPOST http://localhost:8080/packages -H 'content-type: text/plain' -d HotelUrbano

## DELETAR PACKAGE
curl -XDELETE http://localhost:8080/packages/9

## LISTAS PACKAGES
curl -XGET http://localhost:8080/packages
