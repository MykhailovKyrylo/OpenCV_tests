FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive


RUN mkdir /Workspace

WORKDIR /Workspace

ADD . /Workspace/

# Clone, install and test OpenCV

# Install build tools and dependencies (list from OpenCV documentation)
RUN apt-get update && \
	apt-get install -y --no-install-recommends \ 
	build-essential cmake git pkg-config libgtk-3-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
    gfortran openexr libatlas-base-dev python3-dev python3-numpy \
    libtbb2 libtbb-dev libdc1394-22-dev libopenexr-dev \
    libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev \
    ca-certificates

# Clone

RUN cd /Workspace && \
    git clone https://github.com/opencv/opencv.git && \
    git clone https://github.com/opencv/opencv_contrib.git

# Test

RUN chmod +x run_tests.sh && \
    ./run_tests.sh
