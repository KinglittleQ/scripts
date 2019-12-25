import sys
import subprocess
import os
import getpass


DOCKER_CMD = 'docker'
SHELL = 'bash'
HOME_DIR = os.path.expanduser('~')
USER_NAME = getpass.getuser()
HOST_NAME = 'deng_docker'
DATA_DIRS = ['/data', '/data2', '/private', '/nfs', '/onboard_data']


def volumes():
    cmd = [f'--volume={HOME_DIR}:/home/{USER_NAME}']
    for data_dir in DATA_DIRS:
        cmd.append(f'--volume={data_dir}:{data_dir}')

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
        '--ipc=host',
        f'--hostname={container_name}',
        f'--workdir=/home/{USER_NAME}',
        *volumes(),
        image_name,
        SHELL,
    ]

    print(cmd)
    subprocess.run(cmd)


if __name__ == '__main__':
    main()
