FROM nginx:alpine

COPY default.conf /etc/nginx/conf.d

#Adicionando os logs do nginx para ser visualizados através do docker logs
RUN ln -sf /dev/stdout /var/log/nginx/access.log \ 
	&& ln -sf /dev/stderr /var/log/nginx/error.log

ENTRYPOINT ["nginx", "-g", "daemon off;"] 