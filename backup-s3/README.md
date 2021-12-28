# Hassio Addon for Backing up to S3 Bucket

Add-on for uploading hass.io snapshots to AWS S3.

## Installation

Under the Add-on Store tab in the Hass.io Supervisor view in HA add this repo as an add-on repository: `https://github.com/wannes-ds/hassio-backup-s3`.

Install, then set the config variables that you obtained from setting up the S3 user and bucket (see below):
access_key: `access key id`
secret_key: `secret access key`
endpoint: `S3 endpoint (host name only)` (e.g. `s3.us-west-001.backblazeb2.com`)
bucket_name: `S3 bucket name`

## Usage
To sync your hass.io backup folder with your S3 storage service just click START in this add-on. It will keep a synced cloud-copy, so any purged backup files will not be kept in your bucket either.

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
