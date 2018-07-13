nvidia-docker rm caffe
nvidia-docker run -t -i --network="host" --ulimit nofile=327680:327680 --ulimit nproc=65536:65536 --name caffe -v /home/jason/DLOS/test:/test -w /test -d splashblot/py-faster-rcnn:latest
