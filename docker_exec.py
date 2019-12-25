import sys
import subprocess
import os
import getpass


DOCKER_CMD = 'docker'
SHELL = 'bash'


def main():
    assert len(
        sys.argv) == 2, 'Usage: python docker_exec.py [CONTAINER_NAME]'
    NAME = sys.argv[1]

    print(f'Container name: {NAME}')

    cmd = [
    	DOCKER_CMD, 'exec', 
		'-it', 
		'-e COLORTERM=$COLORTERM',
		f'{NAME}', 
		SHELL
	]
    subprocess.run(cmd)


if __name__ == '__main__':
    main()
