FROM pool1892/docker:caffe_pre

MAINTAINER Christoph Schwerdtfeger

# Install Caffe
RUN cd /root && \
	git clone https://github.com/weiliu89/caffe.git  && \
	cd /root/caffe && \
	git checkout ssd && \
	cd /root/caffe && \
	cat python/requirements.txt | xargs -n1 pip install
COPY Makefile /root/caffe/Makefile
COPY Makefile.config /root/caffe/Makefile.config
RUN cd /root/caffe && make all -j"$(nproc)" && \
	make py -j8
RUN cd /root/caffe && make test -j"$(nproc)" && \
	cd /root/caffe && make runtest -j"$(nproc)"


# Set up Caffe environment variables
ENV CAFFE_ROOT=/root/caffe
ENV PYCAFFE_ROOT=$CAFFE_ROOT/python
ENV PYTHONPATH=$PYCAFFE_ROOT:$PYTHONPATH \
	PATH=$CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH

RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly: https://github.com/ipython/ipython/issues/7062
COPY run_jupyter.sh /root/

# Expose Ports for TensorBoard (6006), Ipython (8888)
EXPOSE 6006 8888

WORKDIR "/root"
CMD ["/bin/bash"]
