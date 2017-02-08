FROM pool1892/docker:caffe_opencv_pre

MAINTAINER Luke Miller

ARG CAFFE_VERSION=master

# Install some dependencies
RUN apt-get update && apt-get install -y \
		bc \
		libopenblas-dev \
		python-tk \
		&& \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/* && \
# Link BLAS library to use OpenBLAS using the alternatives mechanism (https://www.scipy.org/scipylib/building/linux.html#debian-ubuntu)
	update-alternatives --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3

# Install other useful Python packages using pip
RUN pip --no-cache-dir install --upgrade ipython && \
	pip --no-cache-dir install \
		easydict \
		path.py \
		pygments \
		sphinx \
		wheel \
		zmq \
		&& \
	python -m ipykernel.kernelspec

# Install Caffe
# Set up Caffe environment variables
ENV CAFFE_ROOT=/root/faster_rcnn/caffe-fast-rcnn
ENV PYCAFFE_ROOT=$CAFFE_ROOT/python
ENV PYTHONPATH=$PYCAFFE_ROOT:$PYTHONPATH \
	PATH=$CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH

RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

# Clone Faster R-CNN WITHOUT recursion
RUN git clone https://github.com/rbgirshick/py-faster-rcnn.git /root/faster_rcnn
# Clone Caffe with Fast R-CNN modification from lukemiller86
RUN git clone https://github.com/lukemiller86/caffe-fast-rcnn.git --branch caffe-update --single-branch /root/faster_rcnn/caffe-fast-rcnn

COPY Makefile.config /root/faster_rcnn/caffe-fast-rcnn/Makefile.config

# Build Caffe and pycaffe
RUN cd /root/faster_rcnn/caffe-fast-rcnn/ && make all -j $(($(nproc) + 1))
RUN cd /root/faster_rcnn/caffe-fast-rcnn/ && make pycaffe

# Rename file in order to run Caffe tests
RUN mv /root/faster_rcnn/caffe-fast-rcnn/src/caffe/test/test_smooth_L1_loss_layer.cpp /root/faster_rcnn/caffe-fast-rcnn/src/caffe/test/test_smooth_L1_loss_layer.cpp.orig

RUN cd /root/faster_rcnn/caffe-fast-rcnn/ && make test -j $(($(nproc) + 1))

# This test is failing to find GPU. nvidia-smi, cuda samples and cifar10 for Caffe all functional. See http://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#runfile-verifications
# RUN cd /root/faster_rcnn/caffe-fast-rcnn/ && make runtest -j $(($(nproc) + 1))

# Restore file we moved earlier
RUN mv /root/faster_rcnn/caffe-fast-rcnn/src/caffe/test/test_smooth_L1_loss_layer.cpp.orig /root/faster_rcnn/caffe-fast-rcnn/src/caffe/test/test_smooth_L1_loss_layer.cpp

# Build Cython modules
RUN cd /root/faster_rcnn/lib/ && make

# Download pre-computed Faster R-CNN detectors
RUN cd /root/faster_rcnn/ && ./data/scripts/fetch_faster_rcnn_models.sh

# Get PASCAL VOC 2007 devkit tar files
RUN wget http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCtrainval_06-Nov-2007.tar && \
	wget http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCtest_06-Nov-2007.tar && \
	wget http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCdevkit_08-Jun-2007.tar

# Untar PASCAL VOC 2007 devkit to data
RUN tar xvf VOCtrainval_06-Nov-2007.tar -C /root/faster_rcnn/data && \
	tar xvf VOCtest_06-Nov-2007.tar -C /root/faster_rcnn/data && \
	tar xvf VOCdevkit_08-Jun-2007.tar -C /root/faster_rcnn/data

# Remove PASCAL VOC 2007 devkit tar files
RUN rm VOCtrainval_06-Nov-2007.tar && \
	rm VOCtest_06-Nov-2007.tar && \
	rm VOCdevkit_08-Jun-2007.tar

# Create symbolic link to PASCAL VOC 2007 devkit
RUN cd /root/faster_rcnn/data && ln -s VOCdevkit VOCdevkit2007

# Download models pretrained on ImageNet
RUN cd /root/faster_rcnn && ./data/scripts/fetch_imagenet_models.sh

# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly: https://github.com/ipython/ipython/issues/7062
COPY run_jupyter.sh /root/

# Expose Ports for Ipython (8888)
EXPOSE 8888

WORKDIR "/root"
CMD ["/bin/bash"]
