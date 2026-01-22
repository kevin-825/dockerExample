NameSpace="kflyn825"
ImageRepositoryName="template"
ImageVerTag="latest"

ImageTag=${NameSpace}/${ImageRepositoryName}:${ImageVerTag}
 
file="Dockerfile"
 
docker build -f "$file" --build-arg HOST_UID=$(id -u) --build-arg HOST_GID=$(id -g) -t $ImageTag .

echo ""
echo ""
echo "Re-tag the image withh the following command:"
echo "docker image tag $ImageTag $NameSpace/$ImageRepositoryName:NewVersion"
echo ""
echo ""
echo "Push the image with the following command:"
echo "docker push $ImageTag"
echo ""