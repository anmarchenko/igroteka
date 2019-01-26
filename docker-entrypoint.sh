#!/bin/bash

export APP="/opt/app/bin/skaro"

### Run database setup, then start the app in the foreground

if [ "$1" = 'init' ]; then
  $APP create_db && $APP migrate && $APP foreground
else
  $APP "$@"
fi
