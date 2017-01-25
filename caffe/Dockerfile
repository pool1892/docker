FROM pool1892/docker:caffe_pre

MAINTAINER Christoph Schwerdtfeger

ENV CAFFE_ROOT=/root/caffe
WORKDIR $CAFFE_ROOT

ENV CLONE_TAG=rc4

RUN git clone -b ${CLONE_TAG} --depth 1 https://github.com/BVLC/caffe.git . && \
    cd python && for req in $(cat requirements.txt) pydot; do pip install $req; done && cd .. && \
    git clone https://github.com/NVIDIA/nccl.git && cd nccl && make -j install && cd .. && rm -rf nccl && \
    mkdir build && cd build && \
    cmake -DUSE_CUDNN=1 -DUSE_NCCL=1 -CUDA_ARCH_NAME=Kepler .. && \
    make -j"$(nproc)"

ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

# Expose Ports for TensorBoard (6006), Ipython (8888)
EXPOSE  8888

WORKDIR "/root/caffe"
CMD ["/bin/bash"]
