ARG  VERSION=latest

FROM quay.io/coreos/clair:${VERSION}

COPY config.yaml /config/config.yaml

CMD ["-config=/config/config.yaml"]
