FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
    && apt-get install -y apt-utils \
    && apt-get install -y golang-go \
    && apt-get install -y libgo13

ENV DEBIAN_FRONTEND newt