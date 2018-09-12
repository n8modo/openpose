# To run the openpose from this image, use the following command:
#`docker run -t -i --net=host -e DISPLAY --device=/dev/video0 --runtime=nvidia -v $HOME/.Xauthority:/home/developer/.Xauthority --rm 721466574657.dkr.ecr.us-east-1.amazonaws.com/openpose:latest`:
#
# To build a new version of this image: `docker build -t 721466574657.dkr.ecr.us-east-1.amazonaws.com/openpose:latest .`
# To publish it" `docker push 721466574657.dkr.ecr.us-east-1.amazonaws.com/openpose:latest`
# For additional command line params: https://github.com/CMU-Perceptual-Computing-Lab/openpose/blob/master/doc/demo_overview.md

FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
MAINTAINER Edmodo

RUN apt-get update && apt-get install -y cmake git sudo python3-pip build-essential libatlas-base-dev libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler libgflags-dev libopencv-dev libgoogle-glog-dev liblmdb-dev libboost-all-dev && \ 
ln -sf /usr/bin/pip3 /usr/bin/pip && rm -rf /var/lib/apt/lists/*
RUN pip install numpy protobuf
RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose
WORKDIR /openpose 
# NOTE: Since the GPU is not availble via the --runtime flag like it is when the container is run
# we must specify the architetures to build here, else it tries to build the sm_20 arch which CUDA 9 does not support.
RUN mkdir build && cd build && cmake -DCUDA_ARCH=Manual -DCUDA_ARCH_BIN="35 52 60 61 70" -DCUDA_ARCH_PTX="70" .. && make -j`nproc`
ENTRYPOINT ["./build/examples/openpose/openpose.bin"]
CMD ["--face","--hand"]
