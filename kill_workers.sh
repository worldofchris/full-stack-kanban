#! /bin/sh

echo "Attempting to gracefully shut down all workers"
ps -e -o pid,command | awk '/[r]esque/ { print $1 }' | xargs kill -QUIT

sleep 5
echo "Killing longer running workers"
ps -e -o pid,command | awk '/[r]esque/ { print $1 }' | xargs kill -9
