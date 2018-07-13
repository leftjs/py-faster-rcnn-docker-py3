nvidia-docker rm caffe
nvidia-docker run -t -i  --ulimit nofile=327680:327680 --ulimit nproc=65536:65536 --name caffe -v /home/jason/DLOS/py-faster-rcnn-docker-py3:/py-faster-rcnn-docker-py3 -w /py-faster-rcnn-docker-py3 -d leftjs/py-faster-rcnn-docker-py3:latest
