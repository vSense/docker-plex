#!/bin/sh
#
# Plex Init Script
#

# Plex ENV VAR
export LD_LIBRARY_PATH=/opt/plexmediaserver
export PLEX_MEDIA_SERVER_HOME=/opt/plexmediaserver
export PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR=/config
export PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS=6
export PLEX_MEDIA_SERVER_TMPDIR=/tmp
export PLEX_MEDIA_SERVER_USER=plex

# Run Plex in background
/opt/plexmediaserver/"Plex Media Server"
