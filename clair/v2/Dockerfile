ARG  VERSION=latest

FROM quay.io/coreos/clair:${VERSION} as src

FROM scratch
COPY --from=src / /
COPY config.yaml /config/config.yaml
#COPY gitconfig /etc/gitconfig

# Copied from the original image
EXPOSE 6060 6061
ENTRYPOINT [ "/clair" ]
CMD ["-config=/config/config.yaml"]
