ARG  VERSION=latest

FROM quay.io/coreos/clair:${VERSION}

COPY config.yaml /config/config.yaml
COPY gitconfig /etc/gitconfig

CMD ["-config=/config/config.yaml"]
