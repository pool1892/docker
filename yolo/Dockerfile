
FROM pool1892/docker:caffe_pre
MAINTAINER Christoph Schwerdtfeger

ENV YOLO=/root/yolo
WORKDIR $YOLO




RUN git clone git@github.com:pool1892/darknet.git . && \
    git checkout docker && \
    make
    


# Expose Ports for TensorBoard (6006), Ipython (8888)
EXPOSE 6006 8888

CMD ["/bin/bash"]
