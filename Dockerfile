FROM docker.artifacts.walmart.com/hub-docker-release-remote/library/ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive
RUN mkdir -p /root/.pip/
COPY pip.conf /root/.pip/pip.conf
RUN apt update -y
RUN apt install golang python3 pip sudo cmake git vim wget -y
RUN python3 -m pip install conan==1.61.0
ENV HTTPS_PROXY="https://sysproxy.wal-mart.com:8080"
ENV HTTP_PROXY="http://sysproxy.wal-mart.com:8080"
ENV GOPROXY=https://go.ci.artifacts.walmart.com/artifactory/golang-go-release-remote,direct
ENV no_proxy=*.wal-mart.com,*.walmart.com,*.walmart.net,*.wal-mart.net,*.io,center.conan.io,milvus01.jfrog.io,*.com,jfrog-prod-use1-shared-virginia-main.s3.amazonaws.com,github.com,objects.githubusercontent.com,storage.googleapis.com
RUN wget https://github.com/milvus-io/milvus/archive/refs/tags/v2.3.3.tar.gz && tar -xvzf v2.3.3.tar.gz
#RUN wget -O-  https://github.com/Kitware/CMake/releases/download/v3.27.6/cmake-3.27.6-linux-x86_64.tar.gz | sudo tar --strip-components=1 -xz -C /usr/local
COPY cmake-3.27.6-linux-x86_64.tar.gz /tmp
RUN cd /tmp && sudo tar -xvzf cmake-3.27.6-linux-x86_64.tar.gz --strip-components=1 -C /usr/local
RUN cd milvus-2.3.3 && ./scripts/install_deps.sh && `which cmake` --version && make

