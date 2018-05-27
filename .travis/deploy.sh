#!/bin/sh
 
DEPLOY_SERVER="ssh://$( if test "$TRAVIS_BRANCH" = "master"; then
                            echo ${PRODUCTION_DEPLOY_USER}@${PRODUCTION_DEPLOY_HOST}:${PRODUCTION_DEPLOY_PORT}/${PRODUCTION_DEPLOY_REPO}
                        else
                            echo ${STAGING_DEPLOY_USER}@${STAGING_DEPLOY_HOST}:${STAGING_DEPLOY_PORT}/${STAGING_DEPLOY_REPO}
                        fi ).git"

git config --global push.default matching
git config --global user.name "Auto deploy by travis-ci"
git config --global user.email "build@travis-ci.org"
git remote add deploy $DEPLOY_SERVER
git add -f vendor
git commit -m "Travis auto deploy"
git push deploy HEAD:master -f

# Skip this command if you don't need to execute any additional commands after deploying.
#ssh $DEPLOY_USER@$DEPLOY_HOST -p $DEPLOY_PORT <<EOF
#  cd $DEPLOY_DIR # Change to whatever commands you need!
#EOF