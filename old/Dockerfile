# Use an official Ubuntu base image
FROM ubuntu:24.04

# Install required dependencies
RUN --mount=type=cache,target=/var/cache/apt \
    apt-get update && apt-get install -y \
    build-essential \
    gcc \
    gdb \
    clang \
    cmake \
    git \
    wget \
    libglib2.0-dev \
    libfdt-dev \
    libpixman-1-dev \
    pkg-config \
    libncurses5-dev \
    libmpc-dev \
    libmpfr-dev \
    libgmp-dev \
    gawk \
    bison \
    flex \
    texinfo \
    python3 \
    python3-pip \
    valgrind \
    lcov \
    doxygen \
    gperf \
    ninja-build \
    && pip3 install numpy pandas tomli meson pycotap sphinx


# Add a new user and group
RUN groupadd -r duser-kevin && useradd -r -g duser-kevin -m -d /home/duser-kevin duser-kevin
# Set the working directory
WORKDIR /workspace
# Create the directory and set permissions
RUN mkdir -p /workspace && chmod 777 /workspace
USER duser-kevin

# Set environment variables
ENV PATH="/opt/qemu/bin:/opt/riscv/bin:/opt/openocd/bin:${PATH}"

# Set the default command to run when the container starts
CMD ["bash"]

# Add a .dockerignore file
# Create a .dockerignore file to exclude unnecessary files
RUN echo "node_modules\n.git\n*.log" > .dockerignore

LABEL maintainer="kflyn825@outlook.com"
LABEL version="1.0"
LABEL description="A development environment for RISC-V"
