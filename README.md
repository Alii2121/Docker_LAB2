## Docker Lab 2

P1- Create Nginx image based on ubuntu from a Dockerfile
```bash 
touch index1.html index.tar
echo "Hello This is Ali's file1" >> index1.html
echo "file2" >> index2.tar
touch Dockerfile 
vim Dockerfile
```
```Dockerfile
FROM ubuntu:23.04
RUN apt-get update
RUN  apt-get -y install nginx
COPY ./index1.html /var/www/html
ADD ./index2.tar /var/www/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
```
```bash
docker build -t ali:1.23 .
docker run -d -p 8099:80 --name ali_nginx ali:1.23
```
P2-
