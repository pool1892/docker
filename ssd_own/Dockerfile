FROM pool1892/docker:caffe_pre
MAINTAINER Christoph Schwerdtfeger

ENV CAFFE_ROOT=/root/caffe
WORKDIR $CAFFE_ROOT




RUN git clone https://github.com/pool1892/caffe.git . && \
    git checkout own && \
    pip install --upgrade pip && \
    cd python && for req in $(cat requirements.txt) pydot; do pip install $req; done && cd .. && \
    git clone https://github.com/NVIDIA/nccl.git && cd nccl && make -j install && cd .. && rm -rf nccl && \
    mkdir build && cd build && \
    cmake -DUSE_CUDNN=1 -DUSE_NCCL=1 .. && \
    make -j"$(nproc)"
    
RUN mkdir /root/caffe/models/VGGNet && \
	cd /root/caffe/models/VGGNet && \
	wget http://cs.unc.edu/~wliu/projects/ParseNet/VGG_ILSVRC_16_layers_fc_reduced.caffemodel

ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig
ENV DATA=/root/data/


# Expose Ports for TensorBoard (6006), Ipython (8888)
EXPOSE 6006 8888

CMD ["/bin/bash"]
