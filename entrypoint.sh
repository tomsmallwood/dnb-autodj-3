#!/bin/sh

# Give appuser access to local volume
# groupmod -g `ls -ln /app | grep music | grep -v grep | awk ' { print $4 }'` appuser

# Switch to non-root user
# su - appuser

# Start program
eval $( python3.6 -m autodj.main )