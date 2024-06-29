FROM nvidia/cuda:12.3.1-devel-ubuntu20.04
# FROM nvidia/cuda:11.6.1-cudnn8-devel-ubuntu20.04

RUN apt update && apt upgrade -y && \
  DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt install -y \
    vim git tmux cmake wget curl python3 python3-pip \
    clang ninja-build

RUN pip3 install --no-cache --upgrade pip setuptools
RUN --mount=type=cache,target=/root/.cache/pip pip3 install \
  meson ninja

RUN git clone https://github.com/LeelaChessZero/lc0 /root/lc0
WORKDIR /root/lc0
RUN git checkout release/0.31
RUN CC=clang CXX=clang++ ./build.sh

WORKDIR /root
COPY .bash_profile .
RUN echo 'source ~/.bash_profile' >> .bashrc

WORKDIR /root/lc0/build/release
RUN wget https://github.com/LeelaChessZero/lczero-client/releases/download/v34/lc0-training-client-linux
RUN chmod +x lc0-training-client-linux

COPY *.json .
COPY run_on_all_gpus.sh .

# CMD sleep infinity
CMD ["./run_on_all_gpus.sh"]
