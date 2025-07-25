FROM ubuntu:24.04

LABEL maintainer="kevin@riscv.dev"

# 🧠 Environment setup
ENV DEBIAN_FRONTEND=noninteractive
ENV RISCV=/opt/riscv
ENV CODE_REPO=/opt/repos

# 🧰 Install build dependencies and GDB support libs
RUN apt-get update && apt-get install -y sudo \
  device-tree-compiler autoconf automake autotools-dev curl python3 python3-pip python3-tomli \
  libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo \
  gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake \
  libglib2.0-dev libslirp-dev libx11-dev libxext6 libsm6 libncurses5-dev \
  libusb-1.0-0-dev pkg-config libftdi-dev libgtk-3-dev libpixman-1-dev \
  libreadline-dev libssl-dev python3-pyelftools \
  libpython3-dev libncursesw5-dev libxml2-dev libudev-dev \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# user
ENV USER=ubuntu
ENV HOME=/home/$USER
# 🧑‍💻 Create non-root dev user
RUN id -u $USER >/dev/null 2>&1 || useradd --create-home -s /bin/bash -m $USER \
  && echo "$USER:$USER" | chpasswd \
  && adduser $USER sudo \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
  && chown -R $USER:$USER /home/$USER

WORKDIR $CODE_REPO


# QEMU: RISC-V32 & RISC-V64 targets
ENV RISCV_QEMU=${RISCV}/riscv_qemu
RUN git clone https://github.com/qemu/qemu.git \
  && cd qemu && git checkout v10.0.3 \
  && mkdir build && cd build \
  && ../configure \
       --target-list=riscv32-softmmu,riscv64-softmmu,riscv32-linux-user,riscv64-linux-user \
       --prefix=$RISCV_QEMU \
  && make -j$(nproc) && make install

# # Spike (ISA simulator)
ENV RISCV_ISA_SIM=${RISCV}/riscv_isa_sim
RUN apt-get update && apt-get install -y device-tree-compiler && git clone https://github.com/riscv/riscv-isa-sim.git \
  && cd riscv-isa-sim && mkdir build && cd build \
  && ../configure --prefix=$RISCV_ISA_SIM \
  && make -j$(nproc) && make install


# Clone riscv-gnu-toolchain once
RUN git clone https://github.com/riscv-collab/riscv-gnu-toolchain

WORKDIR $CODE_REPO/riscv-gnu-toolchain
# Init only specific submodules (e.g. gcc and binutils)
RUN git submodule update --init gcc

ENV RISCV_NEWLIB=${RISCV}/gnu_toolchain_newlib
RUN mkdir build-newlib && cd build-newlib \
  && GDB_NATIVE_FLAGS_EXTRA="--with-python=/usr --with-expat --with-system-readline" \
     GDB_TARGET_FLAGS_EXTRA="--with-python=/usr --with-expat --with-system-readline" \
     ../configure \
       --prefix=$RISCV_NEWLIB \
       --disable-linux \
       --enable-multilib \
       --with-arch=rv64gc \
       --with-abi=lp64d \
       --with-cmodel=medany \
       --with-languages=c,c++ \
  && make -j$(nproc)

# Build Linux (glibc) toolchain in build-linux/

# ENV RISCV_LINUX=${RISCV}/gnu_toolchain_linux
# RUN mkdir build-linux && cd build-linux \
#   && GDB_NATIVE_FLAGS_EXTRA="--with-python=/usr --with-expat --with-system-readline" \
#      GDB_TARGET_FLAGS_EXTRA="--with-python=/usr --with-expat --with-system-readline" \
#      ../configure \
#        --prefix=$RISCV_LINUX \
#        --enable-linux \
#        --enable-multilib \
#        --enable-default-pie \
#        --enable-strip \
#        --with-arch=rv64gc \
#        --with-abi=lp64d \
#        --with-cmodel=medany \
#        --with-languages=c,c++ \
#        --with-multilib-generator="rv64gc-lp64d;rv32gc-ilp32d" \
#   && make -j$(nproc) linux

WORKDIR $CODE_REPO

# riscv-pk (proxy kernel)
ENV RISCV_PK=${RISCV}/riscv_pk
RUN git clone https://github.com/riscv/riscv-pk.git \
  && cd riscv-pk && mkdir build && cd build \
  && ../configure --prefix=$RISCV_PK --host=riscv64-unknown-elf \
  && make -j$(nproc) && make install

# 🧠 Set PATH
ENV PATH="$RISCV_LINUX/bin:$RISCV_NEWLIB/bin:\
$RISCV_PK/riscv64-unknown-elf/bin:$RISCV_PK/riscv64-unknown-linux-gnu/bin:\
$RISCV_ISA_SIM/bin:\
$RISCV_QEMU/bin:\
$HOME/.local/bin:$PATH"

# ⛳ Workspace setup
USER $USER
WORKDIR $HOME
RUN mkdir -p $HOME/workspaces && chown -R $USER:$USER $HOME/workspaces
WORKDIR $HOME/workspaces
RUN echo  "if [ -f $HOME/workspaces/.bash_tmp_rc ]; then" >> ~/.bashrc \
  && echo "    . $HOME/workspaces/.bash_tmp_rc" >> ~/.bashrc \
  && echo "fi" >> ~/.bashrc

#EXPOSE 8080

CMD ["/bin/bash"]