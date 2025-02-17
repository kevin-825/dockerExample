
username=kflyn825
reponame=embed-dev-env
docker_file=$1
tag=$2
#sudo apt-get update
#sudo apt-get install --only-upgrade docker-ce docker-ce-cli containerd.io
#docker buildx version
docker images -a
export DOCKER_CLI_EXPERIMENTAL=enabled
export DOCKER_BUILDKIT=1
docker buildx create --use
docker buildx build --pull --cache-from=ubuntu:24.04 \
--cache-from=moby/buildkit:buildx-stable-1 \
-t $username/$reponame:$tag \
-f $docker_file . --load

docker images
docker save -o ./$tag.tar $username/$reponame:$tag
docker push $username/$reponame:$tag
#kflyn825/embed-dev-env
