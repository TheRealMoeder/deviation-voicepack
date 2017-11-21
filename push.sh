#!/bin/sh

setup_git() {
  cd
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
  git clone --branch master https://${GITHUB_TOKEN}@github.com/TheRealMoeder/TheRealMoeder.github.io.git TheRealMoeder/TheRealMoeder.github.io > /dev/null 2>&1
  cd TheRealMoeder/TheRealMoeder.github.io
}

commit_website_files() {
  cp ../deviation-voicepack/genspeech/voice${GLOBAL_LANG}${VOICE}${BUILD_ID}.zip .
  ../deviation-voicepack/create_index.sh
  git add index.md
  git add voice${GLOBAL_LANG}${VOICE}${BUILD_ID}.zip
  git commit --message "$TRAVIS_COMMIT_MESSAGE"
}

upload_files() {
  git remote add origin-pages https://${GH_TOKEN}@github.com/MVSE-outreach/resources.git > /dev/null 2>&1
  git push --quiet
}

setup_git
commit_website_files
upload_files
