#!/usr/bin/env bash

# ========================================================
# File: docker_run.sh
# -----
# Author: Chengqi Deng
# Email: checkdeng0903@gmail.com
# =======================================================


SCRIPTS_DIR=$(cd "$(dirname "$0")" && pwd)
source $SCRIPTS_DIR/env.sh
LAB="$(lab)"

SHELL="zsh"
HOME_DIR=$HOME
DOCKER_HOME=/home/$USER
HOST_NAME="deng_in_docker"
WORK_DIR="$(pwd)"
BASE_DIR="$(basename $WORK_DIR)"
DOCKER_NAME="dev_in_$BASE_DIR"
DOCKER_WORK_DIR=/app

USER_ID=$(id -u)
GROUP_ID=$(id -g)
SERVER=$(server)
TAG="v0.1"

PROXY=$(http_proxy)

BASE_IMG_NAME="$SERVER/$USER/pytorch:$TAG"
IMG_NAME="$USER/dev_in_pytorch"
DOCKER_FILE_DIR="$SCRIPTS_DIR/dockerfiles"

echo "Work dir: $WORK_DIR"

function local_volumes() {
  volumes="-v $HOME/.cache:${DOCKER_HOME}/.cache \
           -v $HOME/.ssh:${DOCKER_HOME}/.ssh \
           -v $HOME/.zsh_history:${DOCKER_HOME}/.zsh_history \
           -v $HOME/.oh-my-zsh:${DOCKER_HOME}/.oh-my-zsh \
           -v $HOME/.docker.zshrc:${DOCKER_HOME}/.zshrc \
           -v $HOME/.deng.zshrc:${DOCKER_HOME}/.deng.zshrc \
           -v $HOME/.gitconfig:${DOCKER_HOME}/.gitconfig \
           -v $HOME/scripts:${DOCKER_HOME}/scripts \
           -v /dev/null:/dev/raw1394 \
           -v /tmp/core:/tmp/core \
           -v /proc/sys/kernel/core_pattern:/tmp/core_pattern:rw \
           -v /tmp/.ssh-agent-$USER:/tmp/.ssh-agent-$USER \
           -v /data:/data \
           -v $WORK_DIR:$DOCKER_WORK_DIR"

  if [ "$LAB" = "FABU" ]; then
    volumes="${volumes} -v /data2:/data2 \
                        -v /private:/private \
                        -v /nfs:/nfs \
                        -v /onboard_data:/onboard_data"
  fi

  if [[ "$(uname -s)" == *"Linux"* ]]; then
    volumes="${volumes} -v /tmp/.X11-unix/X${DISPLAY_NUM}:/tmp/.X11-unix/X0:rw \
                        -v /media:/media \
                        -v /run/udev:/run/udev:ro \
                        -v /etc/localtime:/etc/localtime:ro \
                        -v /dev/v4l:/dev/v4l \
                        -v /dev/serial:/dev/serial \
                        -v /var/log/auth.log:/var/log/auth.log"
  elif [[ "$(uname -s)" == *"Darwin"* ]]; then
    chmod -R a+wr ~/.cache/bazel
  fi

  if [ -f /bin/lsblk_real ]; then
      volumes="$volumes -v /bin/lsblk:/bin/lsblk"
  fi

  mkdir -p /tmp/.ssh-agent-$USER 2>&1 >/dev/null
  echo "${volumes}"
}

function build_base_image() {
  echo "$INFO Start building base image: $BASE_IMG_NAME ..."

  docker pull $BASE_IMG_NAME
  docker images --format "{{.Repository}}:{{.Tag}}" | grep "${BASE_IMG_NAME}" 1>/dev/null
  if [ $? == 0 ]; then
    echo "$INFO Image ${BASE_IMG_NAME} already exits, continue ..."
    return
  fi

  echo "$INFO Building $BASE_IMG_NAME"
  docker build -t $BASE_IMG_NAME \
               --network host \
               --build-arg HTTP_PROXY=$PROXY \
               --build-arg HTTPS_PROXY=$PROXY \
               -f "$DOCKER_FILE_DIR/Dockerfile.base" \
               .

  echo "$INFO Build base image successfully"
  docker push $BASE_IMG_NAME
}

function print_status() {
  echo "$INFO user = $USER, uid = $USER_ID, gid = $GROUP_ID"
  echo "$INFO base-image = $BASE_IMG_NAME"
  echo "$INFO hostname = $HOST_NAME, container = $DOCKER_NAME, image = $IMG_NAME"
  echo "$INFO server = $SERVER"
  echo "$INFO work-dir = $WORK_DIR"
}

function main() {
  print_status
  login

  # Build base image
  build_base_image

  docker ps -a --format "{{.Names}}" | grep "${DOCKER_NAME}" 1>/dev/null
  if [ $? == 0 ]; then
    echo "$ERROR ${DOCKER_NAME} already exits"
    exit 1
  fi

  echo "$INFO Building image for user"
  # Build image for user
  docker build -t $IMG_NAME \
               --network host \
               --build-arg HTTP_PROXY=$PROXY \
               --build-arg HTTPS_PROXY=$PROXY \
               --build-arg USER_ID=$USER_ID \
               --build-arg GROUP_ID=$GROUP_ID \
               --build-arg USER=$USER \
               --build-arg SERVER=$SERVER \
               --build-arg TAG=$TAG \
               -f "$DOCKER_FILE_DIR/Dockerfile.user" \
               .
  
  echo "$INFO Start container"
  # Start container
  docker run -it --init \
         --runtime=nvidia \
         --user=$USER \
         --ipc=host \
         --hostname=$HOST_NAME \
         --name=$DOCKER_NAME \
         --workdir=$DOCKER_WORK_DIR \
         --dns=114.114.114.114 \
         --net=host \
         $(local_volumes) \
         $IMG_NAME \
         $SHELL
}

main
