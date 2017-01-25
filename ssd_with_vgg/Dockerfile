FROM pool1892/docker:caffe_pre

MAINTAINER Christoph Schwerdtfeger

RUN mkdir /root/caffe/models/VGGNet && \
	cd /root/caffe/models/VGGNet && \
	wget http://cs.unc.edu/~wliu/projects/ParseNet/VGG_ILSVRC_16_layers_fc_reduced.caffemodel

RUN cd root/caffe/data && \
	wget http://host.robots.ox.ac.uk/pascal/VOC/voc2012/VOCtrainval_11-May-2012.tar && \
	wget http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCtrainval_06-Nov-2007.tar && \
	wget http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCtest_06-Nov-2007.tar && \
	tar -xvf VOCtrainval_11-May-2012.tar && \
	tar -xvf VOCtrainval_06-Nov-2007.tar && \
	tar -xvf VOCtest_06-Nov-2007.tar

RUN cd /root/caffe && ./data/VOC0712/create_list.sh && \
	./data/VOC0712/create_data.sh
EXPOSE 6006 8888

WORKDIR "/root"
CMD ["/bin/bash"]