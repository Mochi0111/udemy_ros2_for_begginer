FROM osrf/ros:jazzy-desktop

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    tzdata \
    build-essential \
    sudo \
    curl \
    git \
    tmux \
    xclip \
    cmake \
    clang \
    libssl-dev \
    vim \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "source /opt/ros/jazzy/setup.bash" >> /etc/bash.bashrc

ENV UV_SYSTEM_PYTHON=true \
    UV_LINK_MODE=copy

## uvインストール. どの権限でも(システム全体で)uvが使えるように"/usr/local/bin"にコピー
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && \
    mv /root/.local/bin/uv /usr/local/bin/ && \
    rm /uv-installer.sh

## 任意のディレクトリパス + 作業ディレクトリの所有者を設定
ARG DIR
WORKDIR /${DIR}

COPY . .

## 非rootユーザで実行 
## ※ubuntu24.04イメージの場合, uid=1000のユーザーが"ubuntu"で割当済み.
RUN chown -R ubuntu:ubuntu /${DIR}
USER ubuntu

CMD ["bash"]
