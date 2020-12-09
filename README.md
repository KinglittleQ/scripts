## Scripts to configure servers.

My personal scripts to auto-configure in new machines.

### `install.sh`

Automatically
1. Link all dotfiles
2. Download `v2ray` and run it on port `7891`
3. Set proxy as `127.0.0.1:7891`
3. Download `oh-my-zsh` and `autosuggestion` package
4. Set `oh-my-zsh` theme as `ys`, enable `autosuggestion` package

### `docker_run.sh`

Automatically
1. Build a docker image if not exists (using proxy `127.0.0.1:7891`)
2. Push the built image to the docker server
3. Create a user with the same user name, user id and group id as the host user
4. Start a container with the name `dev_in_$(PWD)`

### `docker_exec.sh`
Connect to a running container named `dev_in_$(PWD)`

### `env.sh`
Some util functions and environment variables.
The proxy could be disabled by replacing `127.0.0.1:7891` with an empty string.

### Packages in docker:
1. Python 3.7
1. Pytorch 1.6
2. OpenCV 3
3. gcc-7, g++-7
4. libboost-all-dev
5. CMake
6. wget, curl
7. sudo

**NOTE:** `sudo` is enabled without password
