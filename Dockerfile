FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    cmake \
    g++ \
    libssl-dev \
    zlib1g-dev \
    libgcrypt20-dev \
    make \
    curl \
    wget

RUN git clone --recursive https://github.com/tdlib/telegram-bot-api.git

RUN mkdir -p telegram-bot-api/build
WORKDIR /telegram-bot-api/build

RUN cmake -DCMAKE_BUILD_TYPE=Release ..

RUN cmake --build . --target install

EXPOSE 8080

CMD ["telegram-bot-api", "--http-port", "8080", "--dir", "/var/lib/telegram-bot-api"]
