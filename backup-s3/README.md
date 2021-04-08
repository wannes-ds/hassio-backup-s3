# Hassio Addon for Backing up to S3 Bucket

Add-on for uploading hass.io snapshots to AWS S3.

## Installation

Under the Add-on Store tab in the Hass.io Supervisor view in HA add this repo as an add-on repository: `https://github.com/mikebell/hassio-backup-s3`.

Install, then set the config variables that you obtained from setting up the AWS account, user and bucket (see below):
awskey: `access key id`
awssecret: `secret access key`
bucketname: `AWS S3 bucket name`

Steps to setting up an Amazon AWS account:
1. Go to https://portal.aws.amazon.com/billing/signup#/start

2. Create a bucket following the standard settings (any name will do):
https://s3.console.aws.amazon.com/s3/

Note the AWS S3 Bucket name

3. Create a specific user with AmazonS3FullAccess rights
https://console.aws.amazon.com/iam

Make sure that after completing the user creation wizard you note down the Access key ID and Secret Access Key. Especially the Secret Access Key will only be displayed once.

The policy should look something like:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:AbortMultipartUpload",
                "s3:DeleteObjectVersion",
                "s3:ListBucket",
                "s3:DeleteObject",
                "s3:ListMultipartUploadParts"
            ],
            "Resource": [
                "arn:aws:s3:::MYBUCKETHERE",
                "arn:aws:s3:::MYBUCKETHERE/*"
            ]
        }
    ]
}
```


## Usage
To sync your HASSIO backup folder with AWS just click START in this add-on. It will keep a synced cloud-copy, so any purged backup files will not be kept in your bucket either.

You could automate this using Automation:

```
# backups
- alias: Make snapshot
  trigger:
    platform: time
    at: '3:00:00'
  condition:
    condition: time
    weekday:
      - mon
  action:
    service: hassio.snapshot_full
    data_template:
      name: Automated Backup {{ now().strftime('%Y-%m-%d') }}

- alias: Upload to S3
  trigger:
    platform: time
    at: '3:30:00'
  condition:
    condition: time
    weekday:
      - mon
  action:
    service: hassio.addon_start
    data:
      addon: local_backup_s3
```
The automation above first makes a snapshot at 3am, and then at 3.30am uploads to S3.

## Help and Debug

Please post an issue on this repo with your full log.

## Alternative Backup solution
I really like this community integration too:
https://github.com/jcwillox/hass-auto-backup

Once installed, it can be easily adapted to run alongside this addon.

Contact: hello@mikebell.io

Credits: Based on jperquin/hassio-backup-s3 based on rrostt/hassio-backup-s3
