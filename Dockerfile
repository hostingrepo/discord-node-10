FROM ubuntu:18.04

MAINTAINER David Razdolski, <admin@unreliable.site>

RUN apt update \
    && apt upgrade -y \
    && apt -y install curl software-properties-common locales git \
    && useradd -d /home/container -m container

    # Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

    # NodeJS
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt -y install nodejs

    # PHP 7.2
RUN add-apt-repository -y ppa:ondrej/php \
    && apt update \
    && apt -y install php7.2 php7.2-cli php7.2-gd php7.2-mysql php7.2-pdo php7.2-mbstring php7.2-tokenizer php7.2-bcmath php7.2-xml php7.2-fpm php7.2-curl php7.2-zip

    # OpenJDK 8
RUN apt -y install openjdk-8-jdk

    # Python 2 & 3
RUN add-apt-repository -y ppa:deadsnakes/ppa \
    && apt update \
    && apt -y install python3.7 python2.6

    # C Sharp & .NET
RUN apt -y install mono-runtime

    # Lua 5.3
RUN apt -y install lua5.3

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
COPY ./bashrc /home/container/.bashrc

CMD ["/bin/bash", "/entrypoint.sh"]
