#!/bin/bash
echo "Building Dockerfile"
sudo "docker build pool1892/docker:tensorflow_faster_rcnn ."

echo "Running Container"
sudo "nvidia-docker run -it  -p 8888:8888 -p 6006:6006 -v /home/ubuntu/docker/tensorflow_faster_rcnn/output:/root/faster_rcnn/output -v /home/ubuntu/docker/tensorflow_faster_rcnn/experiments/logs:/root/faster_rcnn/experiments/logs"