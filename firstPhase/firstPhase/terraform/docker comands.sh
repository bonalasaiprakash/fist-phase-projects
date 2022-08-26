docker comands

docker pull imagename

docker images

docker ps or docker ps -a   # to check containers

docker run -d imagename     # to pull images to containers 

docker start containerid    

docker stop containerid   

docker rm containerid      # rm  means remove  container

docker rmi imageid        # rmi means remove image  

docker inspect imagename   # it will show  meta data

docker exec -it containerid /bin/bash   # to go inside the  container

docker run -d --name containername imagename     #  to give name to container and pull image to container

docker volume create volumename # to create volume




