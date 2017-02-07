FROM pool1892/docker:caffe_pre

MAINTAINER Luke Miller

# Install OpenCV dependencies (https://github.com/BVLC/caffe/wiki/OpenCV-3.1-Installation-Guide-on-Ubuntu-16.04)
# Include additional two packages in last line (http://www.pyimagesearch.com/2016/10/24/ubuntu-16-04-how-to-install-opencv/)
RUN apt-get update && apt-get install -y --no-install-recommends \
	unzip ffmpeg qtbase5-dev \
	libopencv-dev libgtk-3-dev libdc1394-22 libdc1394-22-dev libjpeg-dev libpng12-dev libtiff5-dev libjasper-dev \
	libavcodec-dev libavformat-dev libswscale-dev libxine2-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev \
	libv4l-dev libtbb-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev \
	libvorbis-dev libxvidcore-dev v4l-utils \
	libjpeg8-dev libx264-dev

# Build OpenCV (https://github.com/BVLC/caffe/wiki/OpenCV-3.1-Installation-Guide-on-Ubuntu-16.04)
# Include opencv_contrib (https://github.com/opencv/opencv_contrib)
RUN git clone https://github.com/opencv/opencv.git /root/opencv
RUN mkdir /root/opencv/build
RUN git clone https://github.com/opencv/opencv_contrib.git /root/opencv_contrib
RUN cd /root/opencv/build/ && cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local  \
	-D WITH_TBB=ON -D WITH_V4L=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D WITH_CUBLAS=ON \
	-D ENABLE_FAST_MATH=1 -D CUDA_FAST_MATH=1 -D WITH-D CUDA_NVCC_FLAGS="-D_FORCE_INLINES" \
	-D CUDA_GENERATION=Kepler -D OPENCV_EXTRA_MODULES_PATH=/root/opencv_contrib/modules ..
RUN cd /root/opencv/build/ && make -j $(($(nproc) + 1))

# Install OpenCV
RUN cd /root/opencv/build/ && make install
RUN echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf && ldconfig

# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly: https://github.com/ipython/ipython/issues/7062
COPY run_jupyter.sh /root/

# Expose Port for Ipython (8888)
EXPOSE 8888

WORKDIR "/root"
CMD ["/bin/bash"]
