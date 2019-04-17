FROM ubuntu:18.04

RUN apt-get update -y && \
    apt-get -y install \
    locales \
    sudo \
    procps \
    wget \
    unzip \
    ca-certificates \
    curl \
    software-properties-common \
    bash-completion \
    vim \
    git && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -u 1000 -G users,sudo,root -d /home/user --shell /bin/bash -m user && \
    usermod -p "*" user && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

# Install kubectl
RUN apt-get update && \
    apt-get install -y apt-transport-https && \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubectl && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

# Install gcloud
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install google-cloud-sdk -y && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*


# Install helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash

# Install kompose
ENV KOMPOSE_VERSION v1.18.0
RUN curl -L https://github.com/kubernetes/kompose/releases/download/${KOMPOSE_VERSION}/kompose-linux-amd64 -o kompose && \
    chmod +x kompose && \
    mv ./kompose /usr/local/bin/kompose

USER user
WORKDIR /home/user
CMD sudo chown user:user /home/user && /bin/bash
