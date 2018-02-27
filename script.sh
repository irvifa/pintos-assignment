#!/bin/bash -e

function stop() {
	echo "Stopping Pintos..."
	docker stop pintos	
}

function start() {
	TAG=$1
	# To use your code in the container, mount your project directory into the container using Docker volumes.
	# To use your project directory instead of the current working directory, just replace $PWD with your project path.

	echo "Usage: ./script.sh run <tag>"
	echo "Example: ./script.sh run 0.0.1"

	if [[ ! -z "${TAG}" ]]; then
		echo "Running Pintos..."
		docker run --detach --name pintos --volume $PWD:/pintos pintos/dev:${TAG}
	fi
}

function build() {
	TAG=$1

	echo "Usage: ./script.sh build <tag>"
	echo "Example: ./script.sh build 0.0.1"

	if [[ ! -z "${TAG}" ]]; then
		echo "Building Dockerimage for Pintos..."
		docker build -t pintos/dev:${TAG} .
	fi
}

if [[ ! -z "${1}" && "${1}" == "stop" ]]; then
	stop
fi

if [[ ! -z "${1}" && "${1}" == "start" ]]; then
	start "${2}"
fi

if [[ ! -z "${1}" && "${1}" == "build" ]]; then
	build "${2}"
fi