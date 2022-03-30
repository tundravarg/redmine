#!/bin/bash

echo "Setup Redmine..."

service postgresql start &&

cd /opt &&
tar xzf redmine-5.0.0.tar.gz &&
rm redmine-5.0.0.tar.gz &&
ln -s redmine-5.0.0 redmine &&

cd redmine &&

mv $HOME/database.yml config &&
mv $HOME/redmine.sql ./ &&
su postgres -c "psql -f redmine.sql" &&
rm redmine.sql &&

gem install bundler &&
bundle install --without development test &&
bundle exec rake generate_secret_token &&
RAILS_ENV=production bundle exec rake db:migrate &&
RAILS_ENV=production REDMINE_LANG=en bundle exec rake redmine:load_default_data &&

mv $HOME/redmine.sh ./ &&
chmod ugo+x redmine.sh &&

echo "DONE" || ( echo "FAIL"; exit 1 )
