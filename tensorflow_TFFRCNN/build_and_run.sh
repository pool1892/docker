#!/bin/bash
echo "Building Dockerfile"
docker build -t pool1892/docker:tensorflow_TFFRCNN .

echo "Running Container"
nvidia-docker run -it  -p 8888:8888 -p 6006:6006 -v /home/ubuntu/docker/tensorflow_TFFRCNN/output:/root/faster_rcnn/output -v /home/ubuntu/docker/tensorflow_TFFRCNN/logs:/root/faster_rcnn/logs pool1892/docker:tensorflow_TFFRCNN