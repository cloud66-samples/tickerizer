#!/bin/sh

set -e

echo "Environment: $RAILS_ENV"

# install missing gems
bundle check || bundle install --jobs 20 --retry 5

# install node modules
yarn install


/var/app/bin/webpack-dev-server
