FROM nvidia/cuda:8.0-cudnn5-devel

MAINTAINER Christoph Schwerdtfeger

RUN apt-get update --fix-missing &&\
        apt-get install -y --no-install-recommends \
                tar \
                unzip \
                wget \
                git \
                bzip2 \ 
                ca-certificates \
                && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh
ENV PATH /opt/conda/bin:$PATH



RUN conda install -y --channel https://conda.anaconda.org/menpo opencv3

# Install TensorFlow GPU version.
RUN pip install tensorflow-gpu



# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888


WORKDIR "/root"
CMD ["/bin/bash"]
