#!/bin/bash
set -o errexit

if ! [[ "$TRAVIS_PULL_REQUEST" = "false" && "$TRAVIS_BRANCH" = "dev" ]]; then
    echo -e "Skipping site push (TRAVIS_PULL_REQUEST=$TRAVIS_PULL_REQUEST TRAVIS_BRANCH=$TRAVIS_BRANCH)\n"
    exit 0
fi

if [ -z "$GITHUB_TOKEN" ]; then
    echo -e  "\$GITHUB_TOKEN environment variable not set, or not repo owner."
    exit 0
fi

cd output
echo "Running git config"
git init
git config --global user.email "twodopeshaggy@gmail.com"
git config --global user.name "Johnathan Jenkins"
echo "Adding Files"
git add .
git commit -aF- <<EOF
Automated Travis CI Deployment:
https://travis-ci.org/shaggytwodope/shaggytwodope.github.io/builds/$TRAVIS_BUILD_ID
Branch: $TRAVIS_BRANCH
Build ID: $TRAVIS_BUILD_ID
Build Number: $TRAVIS_BUILD_NUMBER
Commit Hash: $TRAVIS_COMMIT
EOF


echo "Adding remote"
git remote add deploy "https://$GITHUB_TOKEN@github.com/shaggytwodope/shaggytwodope.github.io.git" || echo "Remote deploy already exists:"
git remote -v
echo "Pushing commit"
git push deploy master:master --force

