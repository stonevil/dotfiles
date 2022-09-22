#!/usr/bin/env bash
# vim:ft=sh :

if command -v limactl >/dev/null; then
	# lima-vm to support genuine docker
	alias docker='limactl shell docker docker'
	alias docker-stop-all='docker stop $(docker ps -a -q)'
	alias docker-rm-all='docker rm -f $(docker ps -a -q)'
	alias docker-rmi-all='docker rmi -f $(docker images --no-trunc=false -a -q)'
	if [[ $(limactl list docker --format "{{.Status}}") != "Stopped" ]]; then
		export DOCKER_HOST="unix://$HOME/.docker/docker.sock"
	fi

	# lima-vm to support genuine podman
	alias podman='limactl shell podman podman'
	alias podman-stop-all='podman stop $(podman ps -a -q)'
	alias podman-rm-all='podman rm -f $(podman ps -a -q)'
	alias podman-rmi-all='podman rmi -f $(podman images --no-trunc=false -a -q)'
	if [[ $(limactl list podman --format "{{.Status}}") != "Stopped" ]]; then
		export CONTAINER_HOST="unix://$HOME/.podman/podman.sock"
	fi
fi
