FROM nvidia/cuda:7.5-cudnn3-devel
ARG cpu_or_gpu=gpu

COPY files/.screenrc /root/.screenrc

RUN apt-get update && apt-get install -y screen wget nano openssh-client protobuf-compiler bundler libopencv-dev

# RUN wget https://repo.continuum.io/archive/Anaconda2-4.3.1-Linux-x86_64.sh -O ~/anaconda2.sh
COPY /home/jason/anaconda2.sh ~/anaconda2.sh
RUN bash ~/anaconda2.sh -b -p ~/anaconda2
ENV PATH /root/anaconda2/bin:${PATH}
COPY files/caffe-requirements-conda2.txt /tmp/caffe-requirements-conda2.txt
COPY files/.condarc ~/.condarc
COPY files/.gitconfig ~/.gitconfig
RUN conda create -y --name py-faster-r-cnn python=2.7 --file /tmp/caffe-requirements-conda2.txt -c conda-forge -c menpo -c ActivisionGameScience
COPY files/run-on-env /usr/bin/run-on-env
RUN chmod a+x /usr/bin/run-on-env
RUN run-on-env pip install easydict
RUN echo "source activate py-faster-r-cnn" >> /root/.bashrc
RUN rm ~/anaconda2.sh

WORKDIR /root/anaconda2/envs/py-faster-r-cnn
RUN mkdir -p ./etc/conda/activate.d
RUN mkdir -p ./etc/conda/deactivate.d
RUN echo '#!/bin/sh\n\
  export OLD_LD_LIBRARY_PATH=$LD_LIBRARY_PATH\n\
  export LD_LIBRARY_PATH=/root/anaconda2/envs/py-faster-r-cnn/lib:$LD_LIBRARY_PATH\n'\
  > ./etc/conda/activate.d/env_vars.sh
RUN echo '#!/bin/sh\n\
  export LD_LIBRARY_PATH=$OLD_LD_LIBRARY_PATH\n\
  unset OLD_LD_LIBRARY_PATH\n'\
  > ./etc/conda/deactivate.d/env_vars.sh

RUN apt-get install -y git
WORKDIR /root
RUN git clone --recursive https://github.com/splashblot/py-faster-rcnn.git
WORKDIR /root/py-faster-rcnn
# Checking out just particular commit
RUN git fetch && git checkout 88684f2a00918d67ba6bd3ea4c49e32aa4a2f485
COPY files/Makefile-${cpu_or_gpu}.config caffe-fast-rcnn/Makefile.config
WORKDIR /root/py-faster-rcnn/caffe-fast-rcnn
RUN run-on-env make clean && run-on-env make proto && run-on-env make all -j8 && run-on-env make pycaffe
WORKDIR /root/py-faster-rcnn/lib
RUN run-on-env make


# For solving caffe compilation problem with float128 see:
# http://www.pcl-users.org/Installation-Trouble-Boost-float128-td4040519.html

# For solving caffe compilation problem with libpng16-deb see:
# http://stackoverflow.com/questions/31962975/caffe-install-on-ubuntu-for-anaconda-with-python-2-7-fails-with-libpng16-so-16-n

# For solving caffe compilation problem "No to_python (by-value) converter found" see:
# https://github.com/BVLC/caffe/issues/3494

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
