#!/bin/bash
set -e

if [ "$ENV" = 'DEV' ]; then
	echo "Running Development Service" # Run Dev serv
	exec python "identidock.py"
else
	echo "Running Production Server" # Run Prod serv
	exec uwsgi --http 0.0.0.0:9090 --wsgi-file /app/identidock.py \
		--callable app --stats 0.0.0.0:9191
fi
