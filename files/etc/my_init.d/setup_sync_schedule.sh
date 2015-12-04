#!/bin/sh

# Setup cron backup jobs from envs
set -x 

LOGFILE="/var/log/sync.log"

# Do simple local directory backups
if [ ! -z ${SYNC_S3_BUCKET} ] && [ ! -z ${SYNC_LOCAL_DIRECTORY} ]; then
    if [ ! -z "${SYNC_BACKUP_SCHEDULE}" ]; then
        cat > /etc/cron.d/backup_local << _END
    ${SYNC_BACKUP_SCHEDULE} root /usr/local/bin/backup_local.sh ${SYNC_LOCAL_DIRECTORY} s3://${SYNC_S3_BUCKET} >> ${LOGFILE} 2>&1
_END
    fi
    if [ ! -z "${SYNC_RESTORE_SCHEDULE}" ]; then
        cat > /etc/cron.d/restore_s3 << _END
    ${SYNC_RESTORE_SCHEDULE} root /usr/local/bin/restore_s3.sh ${SYNC_LOCAL_DIRECTORY} s3://${SYNC_S3_BUCKET} >> ${LOGFILE} 2>&1
_END
    fi
fi

