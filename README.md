# A prebuilt openpose enviroment compiled to work with CUDA 9.0

This image is based of the docker image provided by NVIDIA that allows access to the graphics card from a docker enviroment. To use this, the docker host must be [prepared](https://github.com/NVIDIA/nvidia-docker). 
***NOTE***: The official installation instructions in the previous link don't seem to result in a working build on Ubuntu 16.04, follow [these](https://gist.github.com/Brainiarc7/a8ab5f89494d053003454efc3be2d2ef) if you run into problems. 


# Running openpose
 To run the openpose from this image, use the following command: `docker run -t -i --net=host -e DISPLAY --device=/dev/video0 --runtime=nvidia -v $HOME/.Xauthority:/home/developer/.Xauthority --rm 721466574657.dkr.ecr.us-east-1.amazonaws.com/openpose:latest`. The default CMDs run the hand and face detection, but you can change this by passing additional arguments at the end of the command line.
 
 This assumes that `/dev/video0` is the webcam you want to use - it must be exposed to the docker container. 
### Potential problems: 
  - Permission denied conencting to XServer: You need to allow the docker container to connect to the display, the quick and dirty fix (though not very secure) is to execute `xhost +` to allow connections from all hosts. There is probbaly a way to do this to (maybe even just +localhost would work since the docker container is sharing the host's network)
  - OpenGL not supported: this is probably because you are running over VNC or some other virtual screen - this must be run on a real screen - you can use [x11vnc](http://www.karlrunge.com/x11vnc)  
 
 
# Build and Deploy New Images
  - To build a new version of this image: `docker build -t 721466574657.dkr.ecr.us-east-1.amazonaws.com/openpose:latest .`
  - To publish it: `docker push 721466574657.dkr.ecr.us-east-1.amazonaws.com/openpose:latest`

# Additional resources:
  - [Demo Overview and parameters](https://github.com/CMU-Perceptual-Computing-Lab/openpose/blob/master/doc/demo_overview.md)

