FROM nvidia/cuda:8.0-cudnn5-devel

MAINTAINER Christoph Schwerdtfeger

# Pick up some TF dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python \
        python-dev \
        rsync \
        software-properties-common \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh &&\
	chmod +x Anaconda3-4.3.1-Linux-x86_64.sh &&\
	./Anaconda3-4.3.1-Linux-x86_64.sh && \
	rm Anaconda3-4.3.1-Linux-x86_64.sh && \
	conda install --channel https://conda.anaconda.org/menpo opencv3

# Install TensorFlow GPU version.
RUN pip install tensorflow-gpu



# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/

# Copy sample notebooks.
# COPY notebooks /notebooks

# Jupyter has issues with being run directly:
#   https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
COPY run_jupyter.sh /

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

# WORKDIR "/notebooks"

