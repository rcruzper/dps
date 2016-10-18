# dps :whale:

Command-line tool to execute most common actions with a docker container via docker ps and [fzf](https://github.com/junegunn/fzf)

## Requirements

- [brew](http://brew.sh/index_es.html)
- [docker](https://docs.docker.com/engine/installation/mac/#/docker-for-mac)
- [fzf](https://github.com/junegunn/fzf)

## Installation

```shell
$ brew tap rcruzper/homebrew-tools
$ brew install dps
```

## Usage

- ```CTRL-i``` inspects the container
- ```CTRL-s``` stops the container
- ```CTRL-x``` starts the container
- ```CTRL-l``` shows container logs
- ```CTRL-e``` opens a terminal into a container
- ```Enter``` copies container id into the clipboard
