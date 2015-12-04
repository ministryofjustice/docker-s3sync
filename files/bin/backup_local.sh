#!/bin/sh
set +x

if [ -z $1 ] || [ -z $2 ]; then
    echo Usage:
    echo "    $(basename $0) <directory> <s3_bucket>"
    exit 1

else 
    echo "`basename $0`: Backing up $1 to $2"
fi

DIRECTORY="$1"
S3_BUCKET="$2"

/usr/local/bin/aws s3 sync ${DIRECTORY} ${S3_BUCKET}
