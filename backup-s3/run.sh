#!/bin/sh

KEY=$(jq -r .access_key /data/options.json)
SECRET=$(jq -r .access_key /data/options.json)
ENDPOINT=$(jq -r .endpoint /data/options.json)
BUCKET=$(jq -r .bucket_name /data/options.json)

now="$(date +'%d/%m/%Y - %H:%M:%S')"

echo "Starting sync to $BUCKET at $now"

export MC_HOST_remote=https://$KEY:$SECRET@$ENDPOINT

mc mirror /backup/ remote/$BUCKET --overwrite --remove

echo "Done"
