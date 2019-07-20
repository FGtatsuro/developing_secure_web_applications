FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

# FYI: https://stackoverflow.com/questions/16296753/can-you-run-gui-applications-in-a-docker-container
RUN apt-get update && apt-get install -y xvfb x11vnc firefox language-pack-ja fonts-noto && rm -rf /var/lib/apt/lists/*
RUN mkdir ~/.vnc && x11vnc -storepasswd 1234 ~/.vnc/passwd

ENV LANG=ja_JP.UTF-8
