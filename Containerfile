FROM quay.io/fedora/fedora:40

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="Dinesh Bhattarai <dineshdb>"

COPY etc/yum.repos.d/ /etc/yum.repos.d/
RUN \
      --mount=type=cache,target=/var/cache/dnf \
      --mount=type=bind,source=./extra-packages,target=/extra-packages \
      grep -v '^#' /extra-packages | xargs dnf install -y

RUN   ln -fs /bin/sh /usr/bin/sh && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update
     
