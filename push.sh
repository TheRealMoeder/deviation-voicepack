#!/bin/bash

setup_git() {
  cd
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
  git clone --branch master https://${GITHUB_TOKEN}@github.com/TheRealMoeder/TheRealMoeder.github.io.git build/TheRealMoeder/TheRealMoeder.github.io > /dev/null 2>&1
  cd build/TheRealMoeder/TheRealMoeder.github.io
}

commit_website_files() {
  cp ../deviation-voicepack/genspeech/voice${GLOBAL_LANG}${VOICE}${BUILD_ID}.zip .
  ../deviation-voicepack/create_index.sh
  git add index.md
  git add voice${GLOBAL_LANG}${VOICE}${BUILD_ID}.zip
  git commit --message "$TRAVIS_COMMIT_MESSAGE"
}

upload_files() {
  git push --quiet
}

echo "Setting up git..."
setup_git
echo "Committing files..."
commit_website_files
echo "Pushing to remote..."
upload_files
