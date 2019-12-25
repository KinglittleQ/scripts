import sys
import subprocess
import os
import getpass


DOCKER_CMD = 'docker'
AUTHOR = '"Check Deng <checkdeng0903@gmail.com>"'


def main():
    assert len(
        sys.argv) >= 3, 'Usage: python docker_commit.py [CONTAINER] [IMAGE] [message(optional)]'
    container_name = sys.argv[1]
    image_name = sys.argv[2]

    print(f'Container name: {container_name}\nImage name: {image_name}')

    cmd = [DOCKER_CMD, 'commit', f'-a {AUTHOR}']
    if len(sys.argv) > 3:
    	cmd += [f'-m {sys.argv[3]}']
    cmd += [container_name, image_name]

    subprocess.run(cmd)


if __name__ == '__main__':
    main()
