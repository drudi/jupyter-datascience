#! /bin/sh

docker run -d -p 8888:8888 -v "$(pwd):/notebooks" mdrudi/jupyter-integrator:0.2
