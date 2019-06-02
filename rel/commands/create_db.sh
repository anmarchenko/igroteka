#!/bin/sh

release_ctl eval --mfa "Skaro.ReleaseTasks.create_db/1" --argv -- "$@"
