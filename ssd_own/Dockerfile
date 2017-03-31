FROM pool1892/docker:ssd

MAINTAINER Christoph Schwerdtfeger

RUN mkdir /root/caffe/models/VGGNet && \
	cd /root/caffe/models/VGGNet && \
	wget http://cs.unc.edu/~wliu/projects/ParseNet/VGG_ILSVRC_16_layers_fc_reduced.caffemodel

RUN mkdir /root/data && cd /root/data && \
	wget https://www.dropbox.com/s/vxoqg0inzletj1r/VOCdevkit_new.zip && \
	unzip VOCdevkit_new.zip && \
	rm VOCdevkit_new.zip

RUN cd /root/caffe && \
    git pull && \
    git checkout own && \
    root/caffe/data/VOC0712/create_list.sh && \
    /root/caffe/data/VOC0712/create_data.sh

        
ENV DATA=/root/data/


EXPOSE 6006 8888

WORKDIR "/root"
CMD ["/bin/bash"]
