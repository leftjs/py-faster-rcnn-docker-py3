nvidia-docker rm caffe
nvidia-docker run -t -i  --ulimit nofile=327680:327680 --ulimit nproc=65536:65536 --name caffe -v /home/jason/DLOS/py-faster-rcnn-py3:/py-faster-rcnn-py3 -w /py-faster-rcnn-py3 -d splashblot/py-faster-rcnn-py3:latest
