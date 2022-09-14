#!/bin/sh

APP_NAME=$(basename $(pwd))

if [ $# -eq 0 ]
  then
    echo "Usage: run.sh [--run (-r), --build (-b), or -tty (-t)]"
  else
    [[ "$@" =~ "--run" || "$@" =~ "-r" ]] && ( docker run -p 500:500/udp -p 4500:4500/udp --rm $APP_NAME )
    [[ "$@" =~ "--build" || "$@" =~ "-b" ]] && ( docker build -t $APP_NAME:latest . )
    [[ "$@" =~ "--tty" || "$@" =~ "-t" ]] && ( docker run -it --entrypoint /bin/sh $APP_NAME )
fi
