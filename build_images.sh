#!/bin/bash

# Default values
tag="latest"
registry_url=""
push_images=false # A flag to determine whether to push images or not

# Read command line arguments
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
  --tag)
    tag="$2"
    shift
    shift
    ;;
  --registry)
    registry_url="$2"
    push_images=true # If a registry_url is specified, set the flag to true
    shift
    shift
    ;;
  *)
    shift
    ;;
  esac
done

applications=("collector" "corrector" "init-db")

# shellcheck disable=SC2155
title() {
  local text="$1:"
  local console_width=$(tput cols)
  local padding_length=$((console_width - ${#text} - 22))
  local padding_line=$(printf "%${padding_length}s" | tr ' ' '=')
  local datetime=$(date +"%Y-%m-%d %H:%M:%S")
  echo
  echo "$text $padding_line $datetime"
}

build_app() {
  local application_name=$1
  local tag=$2
  local registry_url=$3

  title "Building $application_name"
  docker build -t "$application_name:$tag" --file "./Dockerfile_$application_name" .

  # Only tag and push if the push_images flag is true
  if $push_images; then
    title "Pushing $application_name"
    docker tag "$application_name:$tag" "$registry_url/$application_name:$tag"
    docker push "$registry_url/$application_name:$tag"
  fi
}

build() {
  for application in "${applications[@]}"; do
    title "Processing $application $tag"
    build_app "$application" "$tag" "$registry_url"
  done
}

build
