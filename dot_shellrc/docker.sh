#!/usr/bin/env bash
# vim:ft=sh :

# lima-vm to support genuine docker
if command -v limactl >/dev/null; then
	alias docker='lima shell docker docker'
	alias docker-stop-all='docker stop $(docker ps -a -q)'
	alias docker-rm-all='docker rm -f $(docker ps -a -q)'
	alias docker-rmi-all='docker rmi -f $(docker images --no-trunc=false -a -q)'
	if [[ $(limactl list docker --format "{{.Status}}") != "Stopped" ]]; then
		export DOCKER_HOST="unix://$HOME/.docker/docker.sock"
	fi
fi
