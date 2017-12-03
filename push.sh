#!/bin/bash

setup_git() {
  cd
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
  git clone --branch master https://${GITHUB_TOKEN}@github.com/TheRealMoeder/TheRealMoeder.github.io.git build/TheRealMoeder/TheRealMoeder.github.io > /dev/null 2>&1
  cd build/TheRealMoeder/TheRealMoeder.github.io
}

commit_website_files() {
  cp ../deviation-voicepack/genspeech/*.zip .
  ../deviation-voicepack/create_index.sh
  git add index.md
  git add *.zip
  git commit --message "$TRAVIS_COMMIT_MESSAGE"
}

upload_files() {
  git push --quiet
}

remove_old_files() {
  find . -mtime +7 -exec git rm {} \;
}

echo "Setting up git..."
setup_git
echo "Committing files..."
commit_website_files
echo "Removing files older than one week..."
remove_old_files
echo "Pushing to remote..."
upload_files
