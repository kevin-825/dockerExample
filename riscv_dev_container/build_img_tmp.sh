#!/bin/bash

# Map Dockerfiles to custom image names
declare -A DOCKER_MAP=(
  ["Dockerfile1"]="custom_image_1"
  ["Dockerfile2"]="custom_image_2"
  ["Dockerfile3"]="custom_image_3"
)

# Loop through each Dockerfile and use its corresponding image name
for file in "${!DOCKER_MAP[@]}"
do
  IMAGE_NAME="${DOCKER_MAP[$file]}"
  echo "📦 Starting build for $file as $IMAGE_NAME..."

  # Loop until build succeeds
  while true
  do
    docker build -f "$file" -t "$IMAGE_NAME" .

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
