#!/bin/bash

# Map Dockerfiles to custom image names
declare -A DOCKER_MAP=(
  ["Dockerfile_build_pack"]="riscv_u24pack_build:1.0.0"
  ["Dockerfile_dev_env"]="riscv_dev_u24:1.0.0"
)

# Loop through each Dockerfile and use its corresponding image name
for file in "${!DOCKER_MAP[@]}"
do
  IMAGE_NAME="${DOCKER_MAP[$file]}"
  echo "📦 Starting build for $file as $IMAGE_NAME..."

  # Loop until build succeeds
  while true
  do
    docker build -f "$file" --build-arg HOST_UID=$(id -u) --build-arg HOST_GID=$(id -g) -t "$IMAGE_NAME" .

    if [ $? -eq 0 ]; then
      echo "✅ Successfully built $file as $IMAGE_NAME"
      break
    else
      echo "🔁 Build failed for $file. Retrying..."
      sleep 2
    fi
  done
done

echo "🎉 All Dockerfiles built successfully with custom names!"
