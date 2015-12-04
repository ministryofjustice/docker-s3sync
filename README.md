# docker-s3sync

A simple docker container for automating syncing of a directory on ec2 instances.
Access to s3 buckets should be provided through IAM roles.

## Environment variables

    SYNC-LOCAL-DIRECTORY=<local directory to backup>
    SYNC_S3_BUCKET=<s3 bucket to backup to>
    SYNC_BACKUP_SCHEDULE=<cron backup schedule to use>
    SYNC_RESTORE_SCHEDULE=<cron restore schedule to use>

## IAM Policies

## Example

    # Backup /var/log to s3 every 2 minutes and restore every 1
    docker run \
        -v /var/log:/var/log \ 
        -e SYNC_LOCAL_DIRECTORY=/var/log \
        -e SYNC_SCKET=some-test-bucket \
        -e SYNC_RESTORE_SCHEDULE='*/1 * * * *' \
        -e SYNC_BACKUP_SCHEDULE='*/2 * * * *' \
        --name s3sync registry.service.dsd.io/platforms/s3sync:master.latest
