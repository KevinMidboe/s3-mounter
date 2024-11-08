# s3fs mounter

Image for mounting s3 (google) bucket to filesystem.

## build

Build docker image.

```bash
docker build -t s3fs-mounter .
```

## run

Run docker image. Need to run with privileged flag.

```bash
export S3_BUCKET=BUCKET_NAME
export HMAC_KEY=ACCESS_KEY:SECRET

docker run --rm --privileged -e S3_BUCKET -e HMAC_KEY --name s3fs-mounter s3fs-mounter
```
