tag=riscv-dev-env
username=kflyn825
reponame=embed-dev-env

sudo docker images
sudo docker run -v /home/kevin/vhd1/Containers/riscv-dev-env/bin:/bin \
           -v /home/kevin/vhd1/Containers/riscv-dev-env/etc:/etc \
           -v /home/kevin/vhd1/Containers/riscv-dev-env/home:/home \
           -v /home/kevin/vhd1/Containers/riscv-dev-env/lib:/lib \
           -v /home/kevin/vhd1/Containers/riscv-dev-env/lib32:/lib32 \
           -v /home/kevin/vhd1/Containers/riscv-dev-env/lib64:/lib64 \
           -v /home/kevin/vhd1/Containers/riscv-dev-env/libx32:/libx32 \
           -v /home/kevin/vhd1/Containers/riscv-dev-env/media:/media \
           -v /home/kevin/vhd1/Containers/riscv-dev-env/mnt:/mnt \
           -v /home/kevin/vhd1/Containers/riscv-dev-env/opt:/opt \
           -v /home/kevin/vhd1/Containers/riscv-dev-env/root:/root \
           -v /home/kevin/vhd1/Containers/riscv-dev-env/sbin:/sbin \
           -v /home/kevin/vhd1/Containers/riscv-dev-env/srv:/srv \
           -v /home/kevin/vhd1/Containers/riscv-dev-env/tmp:/tmp \
           -v /home/kevin/vhd1/Containers/riscv-dev-env/usr:/usr \
           -v /home/kevin/vhd1/Containers/riscv-dev-env/var:/var \
           -v /home/kevin/vhd1/Containers/riscv-dev-env/workspace:/workspace \
           -it -p 8080:80 $username/$reponame:$tag
#kflyn825/embed-dev-env

#sudo docker run -it -e MY_VAR=my_value riscv-dev-env
#sudo docker run -it -v /path/on/host:/path/in/container riscv-dev-env
#sudo docker run -it -p 8080:80 riscv-dev-env

#sudo docker exec -it <container_id_or_name> /bin/bash
