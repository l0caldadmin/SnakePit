#!/bin/bash

# Activate the virtual environment
source /app/.venv/bin/activate

# Start Flask in the background using nohup
nohup flask run --host=0.0.0.0 &
if ! $? ; then
    echo "Error starting Flask" >> /var/log/snakepit.log
    exit 1
fi

# Start proxy.py in the background
proxy.py --enable-dashboard &
if ! $? ; then
    echo "Error starting proxy.py" >> /var/log/snakepit.log
    exit 1
fi

trap 'stop_services' SIGINT SIGTERM

stop_services() {
    echo "Stopping services..."
    pkill -f "flask run"
    pkill -f "proxy.py"
}

# Keep the container running
wait