#!/bin/bash
# deploy to ./deploy/.dst_uri
# usage : ./deploy/deploy.sh at the repo root

set -ex

DST_URI_FILE="deploy/.dst_uri"
DST_URI=$(<"$DST_URI_FILE")

DST_URI=${DST_URI#ssh://}

USER_AT_HOST_PORT=${DST_URI%%/*}   # bindsoft@192.168.219.48:22
DST_PATH=/${DST_URI#*/}                 # /home/bindsoft/project/...

# 3️⃣ user, host, port 분리
USER=${USER_AT_HOST_PORT%@*}                       # bindsoft
HOST_PORT=${USER_AT_HOST_PORT#*@}                  # 192.168.219.48:22
HOST=${HOST_PORT%%:*}                              # 192.168.219.48
PORT=${HOST_PORT#*:}                               # 22
[ "$HOST" = "$PORT" ] && PORT=22



rsync -arv --exclude 'tas/test/' -e "ssh -p $PORT" . $USER@$HOST:$DST_PATH
