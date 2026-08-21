ARG FEDORA_VERSION=44

FROM ghcr.io/ublue-os/akmods:ogc-${FEDORA_VERSION} AS akmods

FROM quay.io/fedora/fedora-kinoite:${FEDORA_VERSION}

COPY --from=akmods /kernel-rpms /tmp/kernel-rpms

RUN dnf -y remove --no-autoremove \
  kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra && \
  dnf -y install /tmp/kernel-rpms/*.rpm && \
  rm -rf /tmp/kernel-rpms

RUN dnf -y install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
  fedora-repos-archive

RUN dnf -y install gcc steam steam-devices zsh
RUN dnf -y swap ffmpeg-free ffmpeg --allowerasing

RUN dnf clean all && \
  rm -rf /var/cache/* /var/log/* /var/lib/dnf

RUN bootc container lint
RUN ostree container commit
