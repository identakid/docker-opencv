FROM debian:jessie
MAINTAINER identakid.net <ccssdev@identakid.net>

ENV OPENCV_VERSION 3.4.1

RUN set -x && \
	apt-get update && \
	apt-get install -y \
	unzip \
	wget \
	make \
	build-essential \
	cmake \
	git \
	pkg-config \
	libswscale-dev \
	libtbb2 \
	libtbb-dev \
	libjpeg-dev \
	libpng-dev \
	libtiff-dev \
	libjasper-dev

RUN mkdir /tmp/opencv && \
	cd /tmp/opencv && \
	wget -O opencv.zip https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip && \
	unzip opencv.zip && \
	wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip && \
	unzip opencv_contrib.zip && \
	cd /tmp/opencv/opencv-$OPENCV_VERSION && \
	mkdir build && \
	cd build && \
	cmake -D CMAKE_BUILD_TYPE=RELEASE -D WITH_GTK=OFF -D WITH_GTK_2_X=OFF -D WITH_DSHOW=OFF -D WITH_V4L=OFF -D WITH_NVCUVID=OFF -D WITH_1394=OFF -D WITH_GSTREAMER=NO -D WITH_FFMPEG=NO -D WITH_OPENCL=NO -D WITH_IPP=NO -D WITH_MATLAB=NO -D WITH_PVAPI=NO -D WITH_VTK=NO -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv/opencv_contrib-$OPENCV_VERSION/modules -D BUILD_DOCS=OFF BUILD_EXAMPLES=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_opencv_java=OFF -D BUILD_opencv_python=OFF -D BUILD_opencv_python2=OFF -D BUILD_opencv_python3=OFF .. && \
	make -j4 && \
	make install && \
	ldconfig && \
	cd ~ && \
	rm -rf /tmp/opencv
