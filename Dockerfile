FROM alpine:latest

# metadata
LABEL org.opencontainers.image.source=https://github.com/kevinmidboe/s3-mounter
LABEL org.opencontainers.image.description="Mount s3 (google) bucket to folder using s3fs-fuse"
LABEL org.opencontainers.image.licenses=MIT

ENV MNT_POINT=/var/s3fs
ARG S3FS_VERSION=v1.95

# install, compile and cleanup s3fs-fuse
RUN apk --update --no-cache add fuse alpine-sdk automake autoconf libxml2-dev fuse-dev curl-dev git bash; \
  git clone https://github.com/s3fs-fuse/s3fs-fuse.git; \
  cd s3fs-fuse; \
  ./autogen.sh; \
  ./configure; \
  make; \
  make install; \
  make clean; \
  rm -rf /var/cache/apk/*; \
  apk del git automake autoconf

# setup mountpoint
RUN mkdir -p "$MNT_POINT"
WORKDIR "$MNT_POINT"

# copy startup script
COPY startup.sh /app/startup.sh
RUN chmod 500 /app/startup.sh

CMD /app/startup.sh
