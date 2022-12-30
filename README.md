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
P2- Create react app docker container using single and multi stage

```bash
npx create-react-app ali-app
```
```Dockerfile
FROM node
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3099
CMD ["npm","start"]
```
### multi-stage

```Dockerfile
FROM node:alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm build

FROM nginx
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
ENTRYPOINT ["nginx","-g","daemon off;"]
```

P3- Docker Networks

##
###Bridge: This is the default network type. When you create a new container, it is automatically connected to a bridge network. The bridge network allows containers to communicate with each other, as well as with the host machine and external networks.

###Host: This network type removes the network isolation between the container and the host machine. Containers connected to the host network have the same network namespace as the host, and can directly access all network interfaces and resources on the host.

###None: This network type removes all network connectivity from the container. The container is not connected to any networks, and cannot communicate with other containers or the host machine.

###Overlay: This network type allows you to connect containers across multiple Docker hosts. Overlay networks are created using the Docker Swarm mode feature, which enables you to create a cluster of Docker hosts.

###Macvlan: This network type allows you to assign a MAC address to a container and connect it directly to your physical network. This allows the container to have a unique IP address on the network, and enables it to communicate directly with other devices on the network.

###Network Plugin: This network type allows you to use third-party network plugins to create custom network configurations for your containers. This can be useful if you want to use a particular networking protocol or if you need to connect your containers to a specific network infrastructure.~                                                 
P4-Creat Bridge Network between two containers and ping by NAME

```bash
docker network create bridge-network
docker run -dit --name ali_container1 --network bridge-network ubuntu
docker run -dit --name ali_container2 --network bridge-network ubuntu
# From container1
docker exec -it ali_container1 bash
    @ ping ali_container2
# From ali_container2
docker exec -it ali_container2 bash
    @ ping ali_container1
```

P5- Create a Docker-compose file based on P2
##After Running a container called ali_cont from the prev. Dockerfile

```YAML
version: '3'
services:
  ubuntu:
    image: ubuntu
    container_name: ali-ubuntu
    command: npm install
  nginx:
    image: nginx
    container_name: ali_cont
 ports:
      - "8099:80"
```

#Thank You !
~                                       



