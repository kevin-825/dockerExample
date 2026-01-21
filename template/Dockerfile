FROM ubuntu:24.04

LABEL maintainer="kevin@riscv.dev"

# 🧠 Environment setup
ENV DEBIAN_FRONTEND=noninteractive
# user
ENV USER=ubuntu
ENV HOME=/home/$USER


# 🧰 Install build dependencies and GDB support libs
RUN apt-get update && apt-get install -y --no-install-recommends \
sudo \
&& rm -rf /var/lib/apt/lists/*




# 🧑‍💻 Create non-root dev user
RUN id -u $USER >/dev/null 2>&1 || useradd --create-home -s /bin/bash -m $USER \
  && echo "$USER:$USER" | chpasswd \
  && usermod -aG sudo $USER \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
  && chown -R $USER:$USER /home/$USER

# 🧠 Set PATH
ENV PATH="$HOME/.local/bin:$PATH"

# copy tools into container
# 🛠️ Copy prebuilt RISC-V tools into the container
#ARG PRE_BUILT_RV_TOOLS=./pre-built/riscv
#COPY ${PRE_BUILT_RV_TOOLS} ${RISCV}



# ⛳ Workspace setup
USER $USER
WORKDIR $HOME
RUN mkdir -p $HOME/workspaces && chown -R $USER:$USER $HOME/workspaces
WORKDIR $HOME/workspaces
RUN echo  "if [ -f $HOME/workspaces/.bash_aliases ]; then" >> ~/.bashrc \
  && echo "    . $HOME/workspaces/.bash_aliases" >> ~/.bashrc \
  && echo "fi" >> ~/.bashrc \
  && echo  "if [ -f $HOME/workspaces/.bash_aliases_1 ]; then" >> ~/.bashrc \
  && echo "    . $HOME/workspaces/.bash_aliases_1" >> ~/.bashrc \
  && echo "fi" >> ~/.bashrc

#EXPOSE 8080

CMD ["/bin/bash"]

