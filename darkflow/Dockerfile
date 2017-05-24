
FROM pool1892/docker:tf3
MAINTAINER Christoph Schwerdtfeger

ENV DF=/root/darkflow
WORKDIR $DF




RUN git clone https://github.com/thtrieu/darkflow.git . && \
    python3 setup.py build_ext --inplace
    


# Expose Ports for TensorBoard (6006), Ipython (8888)
EXPOSE 6006 8888

CMD ["/bin/bash"]
