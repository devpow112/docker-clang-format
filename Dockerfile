FROM ubuntu:focal-20220113

# set input arguments
ARG CLANG_FORMAT_VERSION="12"

# set default shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# install packages
RUN export DEBIAN_FRONTEND='noninteractive' && \
    echo '###### Set up packages' && \
    apt-get update && \
    apt-get install --no-install-recommends --no-install-suggests -y \
      apt-transport-https \
      apt-utils \
      ca-certificates \
      gnupg \
      wget && \
    URL='https://apt.llvm.org/' && \
    wget -nv -O - "${URL}llvm-snapshot.gpg.key" | apt-key add - && \
    OS_CODENAME=$(grep 'VERSION_CODENAME=' /etc/os-release) && \
    OS_CODENAME=$(echo "${OS_CODENAME}" | awk -F= '{print $2}') && \
    TOOLCHAIN="llvm-toolchain-${OS_CODENAME}-${CLANG_FORMAT_VERSION}" && \
    echo "deb ${URL}${OS_CODENAME} ${TOOLCHAIN} main" > \
      /etc/apt/sources.list.d/llvm.list && \
    echo "deb-src ${URL}${OS_CODENAME} ${TOOLCHAIN} main" >> \
      /etc/apt/sources.list.d/llvm.list && \
    PACKAGE="clang-format-${CLANG_FORMAT_VERSION}" && \
    apt-get update && \
    apt-get install --no-install-recommends --no-install-suggests -y \
      ${PACKAGE} && \
    update-alternatives --install \
      /usr/bin/clang-format clang-format \
      /usr/bin/clang-format-${CLANG_FORMAT_VERSION} 100 && \
    echo '###### Clean up' && \
    apt-get autoremove --purge -y \
      apt-transport-https \
      apt-utils \
      ca-certificates \
      gnupg \
      wget && \
    apt-get autoremove --purge -y && \
    apt-get autoclean && \
    apt-get clean && \
    rm -rf \
      /var/lib/apt/lists/* \
      /var/tmp/* \
      /var/log/* \
      /tmp/*

# default command
CMD ["/bin/bash"]

# labels
LABEL maintainer devpow112 \
      org.opencontainers.image.authors devpow112 \
      org.opencontainers.image.description \
        "Docker container containing all needed tools to run Clang Format." \
      org.opencontainers.image.documentation \
        https://github.com/devpow112/docker-clang-format#readme \
      org.opencontainers.image.licenses MIT \
      org.opencontainers.image.source \
        https://github.com/devpow112/docker-clang-format \
      org.opencontainers.image.title "Docker Clang Format" \
      org.opencontainers.image.url \
        https://github.com/devpow112/docker-clang-format \
      org.opencontainers.image.vendor devpow112
