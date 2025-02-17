tag=$1
username=kflyn825
reponame=embed-dev-env

sudo docker images
sudo docker run -v /home/kevin/vhd1/Containers/$tag/bin:/bin \
           -v /home/kevin/vhd1/Containers/$tag/etc:/etc \
           -v /home/kevin/vhd1/Containers/$tag/home:/home \
           -v /home/kevin/vhd1/Containers/$tag/lib:/lib \
           -v /home/kevin/vhd1/Containers/$tag/lib32:/lib32 \
           -v /home/kevin/vhd1/Containers/$tag/lib64:/lib64 \
           -v /home/kevin/vhd1/Containers/$tag/libx32:/libx32 \
           -v /home/kevin/vhd1/Containers/$tag/media:/media \
           -v /home/kevin/vhd1/Containers/$tag/mnt:/mnt \
           -v /home/kevin/vhd1/Containers/$tag/opt:/opt \
           -v /home/kevin/vhd1/Containers/$tag/root:/root \
           -v /home/kevin/vhd1/Containers/$tag/sbin:/sbin \
           -v /home/kevin/vhd1/Containers/$tag/srv:/srv \
           -v /home/kevin/vhd1/Containers/$tag/tmp:/tmp \
           -v /home/kevin/vhd1/Containers/$tag/usr:/usr \
           -v /home/kevin/vhd1/Containers/$tag/var:/var \
           -v /home/kevin/vhd1/Containers/$tag/workspace:/workspace \
           -it -p 8080:80 $username/$reponame:$tag
#kflyn825/embed-dev-env

#sudo docker run -it -e MY_VAR=my_value $tag
#sudo docker run -it -v /path/on/host:/path/in/container $tag
#sudo docker run -it -p 8080:80 $tag

#sudo docker exec -it <container_id_or_name> /bin/bash
