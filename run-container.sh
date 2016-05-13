#! /bin/sh

docker run -d -p 8888:8888 -v "$(pwd):/notebooks" mdrudi/jupyter-datascience:0.2
