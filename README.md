# README


# Running Locally
## Run React fonrend:
sh -c rm -rf public/packs/* || true && bundle exec rake react_on_rails:locale && bin/webpack-dev-server

OR

sh -c 'rm -rf public/packs/* || true && bundle exec rake react_on_rails:locale && bin/webpack -w'

## Run server:

bs rails s

## Download backup and restore DB:
heroku pg:backups:capture --app monument-monitor
heroku pg:backups:download --app monument-monitor
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U roo -d dino_monitor_development latest.dump

Create dump file
PGPASSWORD=mypassword pg_dump -Fc --no-acl --no-owner -h localhost -U roo dino_monitor_production > ms_prod.dump


## Run instagram scraper
instamancer hashtag monumentmonitor --full --logging=info --visible


## pull changes from Monument Monitor
Checkout a new branch, and pull down from the 'upstream' remote.
Deal with any merge conflicts and HUZZAH!