FROM pool1892/docker:tensorflow_1_0

MAINTAINER Luke Miller

# Faster R-CNN has OpenCV dependency
RUN apt-get update && apt-get install -y --no-install-recommends \
		git \
        python-opencv \
        python-tk \
        libopencv-dev \
        vim \
        wget \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install other useful Python packages using pip
RUN pip --no-cache-dir install --upgrade ipython && \
	pip --no-cache-dir install \
		easydict \
		Cython \
		pyyaml \
		scikit-image \
		&& \
	python -m ipykernel.kernelspec

# Clone Faster R-CNN WITH recursion (now using lukealexmiller's fork)
RUN git clone --recursive https://github.com/lukealexmiller/TFFRCNN.git /root/faster_rcnn

# Build Faster R-CNN
RUN cd /root/faster_rcnn/lib && make -j $(($(nproc) + 1))

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

# Download pre-trained ImageNet models
RUN cd /root/faster_rcnn/data && mkdir pretrain_model && cd pretrain_model && \
	wget https://www.dropbox.com/s/po2kzdhdgl4ix55/VGG_imagenet.npy

# Create 'log' directory. Training will work but no logs will be saved
RUN cd /root/faster_rcnn/experiments && mkdir logs

# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly: https://github.com/ipython/ipython/issues/7062
COPY run_jupyter.sh /root/

# Expose Ports for Tensorboard (6006) and Ipython (8888)
EXPOSE 6006 8888

WORKDIR "/root"
CMD ["/bin/bash"]
