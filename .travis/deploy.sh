#!/bin/sh

DEPLOY_HOST=$([ "$TRAVIS_BRANCH" = "master" ] && echo $PRODUCTION_DEPLOY_HOST || echo $STAGING_DEPLOY_HOST)
DEPLOY_PORT=$([ "$TRAVIS_BRANCH" = "master" ] && echo $PRODUCTION_DEPLOY_PORT || echo $STAGING_DEPLOY_PORT)
DEPLOY_USER=$([ "$TRAVIS_BRANCH" = "master" ] && echo $PRODUCTION_DEPLOY_USER || echo $STAGING_DEPLOY_USER)
DEPLOY_REPO=$([ "$TRAVIS_BRANCH" = "master" ] && echo $PRODUCTION_DEPLOY_REPO || echo $STAGING_DEPLOY_REPO)

git config --global push.default matching
git remote add deploy ssh://$DEPLOY_USER@$DEPLOY_HOST:$DEPLOY_PORT/$DEPLOY_REPO.git
git add -f vendor
git commit --author="Auto deploy by travis-ci <build@travis-ci.org>" -m "Auto deploy: $(date +'%Y-%m-%d %T')"
git push deploy master

# Skip this command if you don't need to execute any additional commands after deploying.
#ssh $DEPLOY_USER@$DEPLOY_HOST -p $DEPLOY_PORT <<EOF
#  cd $DEPLOY_DIR # Change to whatever commands you need!
#EOF