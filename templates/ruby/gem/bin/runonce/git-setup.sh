#!/bin/bash

function kl_subheading {
  echo -e "[ \033[93m$1\033[0m ]"
}

# START OF SCRIPT

kl_subheading "initializing git repository"

# git init
git remote add origin {{dom.repo_info.ssh_link}}
git branch -M main

git add .
git commit -am 'first commit'
git tag v{{dom.initial_semver}} -a -m '{{dom.application}} initialize repository'

git push -u origin main --tags
