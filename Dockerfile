FROM debian:trixie
ENV DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture armel
RUN apt-get update && apt-get install -y \
    crossbuild-essential-armel \
    git \
    build-essential \
    devscripts \
    debhelper \
    pkg-config \
    cmake \
    sudo \
    # Native tools
    python3 \
    valac \
    libglib2.0-dev \
    gobject-introspection \
    libgirepository1.0-dev \
    # ARM Libraries
    libglib2.0-dev:armel \
    libudev-dev:armel \
    libgudev-1.0-dev:armel \
    libpng-dev:armel \
    libfreetype-dev:armel \
    libfontconfig-dev:armel \
    && rm -rf /var/lib/apt/lists/*

    COPY libgrx-3.0*.deb /tmp/
    # Install them
    RUN dpkg -i --force-all /tmp/libgrx-3.0*.deb

RUN useradd -m compiler && echo "compiler ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER compiler
WORKDIR /src