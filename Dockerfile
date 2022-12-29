FROM ubuntu
RUN apt-get update
RUN  apt-get -y install nginx 
COPY index1.html /var/www/html
ADD index2.tar /var/www/html
RUN chmod +x .
EXPOSE 80
CMD ["nginx","-g","daemon off;"]

