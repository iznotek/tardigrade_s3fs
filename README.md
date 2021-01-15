# Usage
## Building docker image
Build the Tardigrade S3 docker image:
```
docker build . -t tardigrade
```

## Running S3 gateway
Run the Tardigrade S3 gateway:
```
docker run -it -p 7777:7777 -e ACCESS_GRANT=TARDIGRADE_ACCESS_GRANT -e MINIO_ACCESS_KEY=MINIO_ACCESS_KEY -e MINIO_SECRET_KEY=MINIO_SECRET_KEY tardigrade
```

## Accessing gateway
You can now access the Minio interface at http://localhost:7777/

Login by the `Access key` and `Secret key` provided on the previous step.

The user-interface should now be used to create a bucket, and the name should be noted down.

## Mounting S3 as local filesystem
Install the S3 fuse package:
```
apt update
apt install s3fs
```

Prepare our credentials file:
```
echo "MINIO_ACCESS_KEY:MINIO_SECRET_KEY" > /opt/tardigrade_s3fs_passwd
chmod 600 /opt/tardigrade_s3fs_passwd
```

Create our mount folder:
```
mkdir -p /media/s3fs
```

Mount the S3 locally:
```
s3fs /media/s3fs/ -o passwd_file=/opt/tardigrade_s3fs_passwd -o url=http://localhost:7777 -o bucket=somebucket -o use_path_request_style
```
