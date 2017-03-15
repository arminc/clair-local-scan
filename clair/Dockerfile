FROM quay.io/coreos/clair:v2.0.0-rc.0

COPY config.yaml /config/config.yaml

ADD https://github.com/arminc/clair/releases/download/temp/analyze-local-images /bin/analyze-local-images

CMD ["-config=/config/config.yaml"]