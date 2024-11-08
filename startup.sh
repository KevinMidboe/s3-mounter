#!/bin/bash

echo "$HMAC_KEY" > /etc/gcs-auth && chmod 600 /etc/gcs-auth
s3fs -d -d "$S3_BUCKET" "$MNT_POINT" \
    -o use_cache=/tmp \
    -o passwd_file=/etc/gcs-auth \
    -o url=https://storage.googleapis.com \
    -o sigv2 \
    -o nomultipart \
    -o cipher_suites=AESGCM \
    -o stat_cache_expire=20,use_cache=1,max_stat_cache_size=60000 \
    -o max_background=1000 \
    -o max_stat_cache_size=100000 \
    -o multipart_size=52 \
    -o parallel_count=30 \
    -o multireq_max=30 \
    -o dbglevel=warn && tail -f /dev/null
