
container_name=$3
USER=user0
if [ -z "$container_name" ]; then
    echo error in container name
fi
#docker ps -a
#docker stop $container_name
#docker rm $container_name
#docker ps -a
#docker images
repo=$1
tag=$2
img=$repo-$tag

mkdir -p ~/Containers
host_dir_for_container=~/Containers/$img

# sudo docker run --name $container_name \
# -v $host_dir_for_container/workspace:/workspace \
# -v $host_dir_for_container/root:/root \
# -v $host_dir_for_container/root/.bash_history:/root/.bash_history \
# -v $host_dir_for_container/opt:/opt \
# -v $host_dir_for_container/home:/home \
# -v /home/kevin/toolchain/officialRiscvToolchain:/home/kevin/tools \
# -v /home/kevin/officialRepos:/home/kevin/officialRepos \
# -v /home/kevin/kflyn825Repos:/home/kevin/kflyn825Repos \
# -v /opt/riscv-gnu-toolchain-u22:/opt/riscv-gnu-toolchain-u22 \
# -it -p 2222:22  $repo:$tag


docker run -it --name $container_name \
-v $host_dir_for_container/workspaces:/home/$USER/workspaces \
-v $host_dir_for_container/root/.bash_history:/root/.bash_history \
-v /:/hst_root \
-P $repo:$tag #bash -c "source /home/ubuntu/.bashrc && /bin/bash"
# Check exit status
if [ $? -ne 0 ]; then
  echo "❌ Container failed to start."
  read -p "Do you want to delete and re-create it? [y/N]: " choice
  case "$choice" in
    y|Y )
      echo "🧨 Removing existing container (if any)..."
      docker rm -f $container_name 2>/dev/null
      echo "🔄 Recreating container..."
      docker run -it --name $container_name \
        -v $host_dir_for_container/workspaces:/home/user0/workspaces \
        -v $host_dir_for_container/root/.bash_history:/root/.bash_history \
        -v /:/hst_root \
        -P $repo:$tag 
      ;;
    * )
      echo "🚪 Exit without re-creating container."
      exit 1
      ;;
  esac
else
  echo "✅ Container started successfully."
fi

docker port $container_name
sudo chown -R user0:user0 /home/user0/workspaces
docker start -ia $container_name

#-u kevin
#-v /opt/riscv-gnu-toolchain-u22/bin:/opt/riscv-gnu-toolchain-u22/bin \
#-v /opt/qemu-riscv:/opt/qemu-riscv \

#sudo docker stop $container_name
#sudo docker start $container_name

#exit
#sudo docker rm $(sudo docker ps -a -q)


#sudo docker ps -a
# sudo docker commit <container_id> <new_image_name>:<tag>

#sudo docker run -v $host_dir_for_container/bin:/bin \
#           -v $host_dir_for_container/etc:/etc \
#           -v $host_dir_for_container/home:/home \
#           -v $host_dir_for_container/lib:/lib \
#           -v $host_dir_for_container/lib32:/lib32 \
#           -v $host_dir_for_container/lib64:/lib64 \
#           -v $host_dir_for_container/libx32:/libx32 \
#           -v $host_dir_for_container/media:/media \
#           -v $host_dir_for_container/mnt:/mnt \
#           -v $host_dir_for_container/opt:/opt \
#           -v $host_dir_for_container/root:/root \
#           -v $host_dir_for_container/sbin:/sbin \
#           -v $host_dir_for_container/srv:/srv \
#           -v $host_dir_for_container/tmp:/tmp \
#           -v $host_dir_for_container/usr:/usr \
#           -v $host_dir_for_container/var:/var \
#           -v $host_dir_for_container/workspace:/workspace \
#           -it -p 2222:22 $repo:$tag /bin/sh
