#!/bin/bash

set -e # Exit with nonzero exit code if anything fails

if git diff-tree --no-commit-id --name-only -r HEAD; then
    echo 'dps code changed, creating release'

    # Save some useful information
    REPO=`git config remote.origin.url`
    SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}

    # Set config
    git config --global user.email "rcruzper@gmail.com"
    git config --global user.name "Travis CI"

    # Create git tag
    export GIT_TAG=`git describe --abbrev=0 --tags | awk -F'[.]' '/^v/ {print $1"."$2"."$3+1}'`
    git tag $GIT_TAG -a -m "Generated tag from TravisCI build $TRAVIS_BUILD_NUMBER"

    # Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
    ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
    ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
    ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
    ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
    openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in deploy_key.enc -out deploy_key -d
    chmod 600 deploy_key
    eval `ssh-agent -s`
    ssh-add deploy_key

    # Now that we're all set up, we can push.
    git push $SSH_REPO --tags
else
    echo 'dps code does not changed'
    exit 1
fi
