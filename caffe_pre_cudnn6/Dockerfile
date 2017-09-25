FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

MAINTAINER Christoph Schwerdtfeger

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        wget \
        libatlas-base-dev \
	libopenblas-dev \
        libboost-all-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libhdf5-serial-dev \
        libleveldb-dev \
        liblmdb-dev \
        libopencv-dev \
        libprotobuf-dev \
        libsnappy-dev \
        unzip \
        protobuf-compiler \
        python-dev \
        python-numpy \
        python-pip \
        python-setuptools \
        python-scipy \
        python-opencv \
    	python-nose \
    	python-h5py \
    	python-skimage \
    	python-matplotlib \
    	python-pandas \
    	python-sklearn \
        python-sympy \
        python-scipy && \
        rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip &&\
    pip --no-cache-dir install \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        scipy \
        sklearn \
        Pillow \
        && \
    python -m ipykernel.kernelspec
    
COPY requirements.txt /root/req.txt
RUN     cd /root && for req in $(cat req.txt) pydot; do pip install $req; done && \
	rm /root/req.txt

# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly: https://github.com/ipython/ipython/issues/7062
COPY run_jupyter.sh /root/

# Expose Ports for TensorBoard (6006), Ipython (8888)
EXPOSE  8888

WORKDIR "/root"
CMD ["/bin/bash"]
