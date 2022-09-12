#!/usr/bin/env bash

working_dir=$(mktemp -d)
repo_dir=${PWD}

(
  cd "${working_dir}"
  
  while read package; do
    wget "https://github.com/Tiger-OperatingSystem/tiger-shell/releases/download/continuous/${packages}.deb"
    dpkg -x "${package}.deb" .
    rm "${package}.deb"
  done < "${repo_dir}/packages.txt"


  mkdir -p var/tiger-update/
  date +%y.%m.%d%H%M%S > var/tiger-update/version

  tar -czvf ../update-pack.tar.gz ./*
  chmod 777 ../update-pack.tar.gz
)

mv /tmp/update-pack.tar.gz tiger-update-package.tgz
cp "${working_dir}/var/tiger-update/version" CURRENT

# sudo tar --same-permissions --same-owner -xzvf tiger-update-package.tgz -C /


