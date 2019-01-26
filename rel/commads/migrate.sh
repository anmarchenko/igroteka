#!/bin/sh

release_ctl eval --mfa "Skaro.ReleaseTasks.migrate/1" --argv -- "$@"
