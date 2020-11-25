import sys
import subprocess
import os
import getpass


DOCKER_CMD = 'docker'
SHELL = 'zsh'
HOME_DIR = os.path.expanduser('~')
USER_NAME = getpass.getuser()
HOST_NAME = 'deng_docker'
DATA_DIRS = ['/data', '/data2', '/private', '/nfs', '/onboard_data',
             f'{HOME_DIR}/.zsh_history', f'{HOME_DIR}/.oh-my-zsh',
             f'{HOME_DIR}/.deng.zshrc', f'{HOME_DIR}/.ssh',
             f'{HOME_DIR}/.gitconfig', f'{HOME_DIR}/scripts']


def volumes():
    cmd = [f'--volume={HOME_DIR}/p2b:/home/{USER_NAME}/p2b']
    cmd += [f'--volume={HOME_DIR}/.docker.zshrc:/home/{USER_NAME}/.zshrc']
    for data_dir in DATA_DIRS:
        cmd.append(f'--volume={data_dir}:{data_dir}:z')

    return cmd


def main():
    assert len(
        sys.argv) == 3, 'Usage: python docker_run.py [CONTAINER_NAME] [IMAGE]'
    container_name = sys.argv[1]
    image_name = sys.argv[2]

    print(f'Container name: {container_name}\nImage name: {image_name}')

    cmd = [DOCKER_CMD, 'run', '-it', '--rm', '--init']
    cmd += [
        f'--name={container_name}',
        '--runtime=nvidia',
        '--user=root:root',
        '--ipc=host',
        f'--hostname={container_name}',
        f'--workdir=/home/{USER_NAME}',
        '--dns=114.114.114.114',
        '--net=host',
        '--user=dengchengqi',
        *volumes(),
        image_name,
        SHELL,
    ]

    print(cmd)
    subprocess.run(cmd)


if __name__ == '__main__':
    main()
