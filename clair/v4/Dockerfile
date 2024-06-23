ARG  VERSION=4.7.4

FROM quay.io/projectquay/clair:${VERSION} as src

COPY config.yaml /config/config.yaml

# Copied from the original image
EXPOSE 8080 8081
ENTRYPOINT ["/bin/clair"]
CMD ["-mode", "combo", "-conf", "/config/config.yaml"]
