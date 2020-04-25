#!/bin/bash

export APP="/opt/app/bin/skaro"

### Run database setup, then start the app in the foreground

if [ "$1" = 'init' ]; then
  $APP eval 'Skaro.Release.migrate()' && $APP start
else
  $APP "$@"
fi
