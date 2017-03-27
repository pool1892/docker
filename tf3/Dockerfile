
FROM continuumio/anaconda3:latest

MAINTAINER Christoph Schwerdtfeger

# Pick up some TF dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        tar \
        unzip \
      	wget \
        git \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN conda install --channel https://conda.anaconda.org/menpo opencv3

# Install TensorFlow GPU version.
RUN pip install tensorflow-gpu



# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888


WORKDIR "/root"
CMD ["/bin/bash"]
