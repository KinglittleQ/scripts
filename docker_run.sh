#!/usr/bin/env bash

SHELL="zsh"
HOME_DIR=$HOME
DOCKER_HOME=/home/$USER
USER_NAME=$USER
HOST_NAME="deng_in_docker"
DOCKER_NAME="dengchengqi_dev_pytorch"

IMG="docker.fabu.ai:5000/dengchengqi/pytorch:v0.1"
DOCKER_FILE_DIR="$HOME/dotfiles"

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
           -v /data2:/data2 \
           -v /private:/private \
           -v /nfs:/nfs \
           -v /onboard_data:/onboard_data \
           -v $HOME/p2b:${DOCKER_HOME}/p2b"

  case "$(uname -s)" in
  Linux)
    volumes="${volumes} -v /tmp/.X11-unix/X${DISPLAY_NUM}:/tmp/.X11-unix/X0:rw \
                        -v /media:/media \
                        -v /run/udev:/run/udev:ro \
                        -v /etc/localtime:/etc/localtime:ro \
                        -v /private:/private \
                        -v /data:/data \
                        -v /onboard_data:/onboard_data \
                        -v /dev/v4l:/dev/v4l \
                        -v /dev/serial:/dev/serial \
                        -v /var/log/auth.log:/var/log/auth.log"
    ;;
  Darwin)
    chmod -R a+wr ~/.cache/bazel
    ;;
  esac

  if [ -f /bin/lsblk_real ]; then
      volumes="$volumes -v /bin/lsblk:/bin/lsblk"
  fi

  mkdir -p /tmp/.ssh-agent-$USER 2>&1 >/dev/null
  echo "${volumes}"
}

function main() {
  docker pull $IMG

  docker ps -a --format "{{.Names}}" | grep "${DOCKER_NAME}" 1>/dev/null
  if [ $? == 0 ]; then
    echo "${DOCKER_NAME} already exits"
    exit 1
  fi

  USER_ID=$(id -u)
  GROUP_ID=$(id -g)
  IMG_NAME="$USER/dev_in_pytorch"

  docker build -t $IMG_NAME \
               --build-arg USER_ID=$USER_ID \
               --build-arg GROUP_ID=$GROUP_ID \
               --build-arg USER=$USER \
               $DOCKER_FILE_DIR
  
  docker run -it --init \
         --runtime=nvidia \
         --user=$USER \
         --ipc=host \
         --hostname=$HOST_NAME \
         --name=$DOCKER_NAME \
         --workdir=$DOCKER_HOME \
         --dns=114.114.114.114 \
         --net=host \
         $(local_volumes) \
         $IMG_NAME \
         $SHELL
}

main
