FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

# $ docker build . -t firefox_vnc
# $ docker run --name vnc -d -it -p 5900:5900 firefox_vnc:latest /usr/bin/x11vnc -forever -usepw -create
# $ docker rm -f vnc

# FYI:
#   VNC:
#     - https://stackoverflow.com/questions/16296753/can-you-run-gui-applications-in-a-docker-container
#   Firefox addon:
#     - https://askubuntu.com/questions/73474/how-to-install-firefox-addon-from-command-line-in-scripts
#     - https://gist.github.com/eddiejaoude/0076739fe610189581d0
RUN apt-get update && apt-get install -y twm xvfb x11vnc firefox \
	language-pack-ja fonts-noto \
	fcitx-mozc dbus-x11 \
	&& rm -rf /var/lib/apt/lists/*

# Mozc doesn't support root user
# https://wiki.archlinux.jp/index.php/Mozc#mozc_server_.E3.81.8C_defunct_.E3.81.AB.E3.81.AA.E3.82.8B
RUN useradd -m user
USER user

RUN mkdir ~/.vnc && x11vnc -storepasswd 1234 ~/.vnc/passwd

RUN echo 'fcitx &' >> ~/.xinitrc
RUN echo 'xterm &' >> ~/.xinitrc
RUN echo 'firefox &' >> ~/.xinitrc
RUN echo 'exec twm' >> ~/.xinitrc
RUN chmod +x ~/.xinitrc

# need window manager for avoid firefox focus issue
# https://manpages.debian.org/wheezy/xmanpages-ja/twm.1.ja.html
RUN echo 'RandomPlacement' >> ~/.twmrc
#RUN echo 'NoTitle' >> ~/.twmrc

ENV LANG=ja_JP.UTF-8
ENV DISPLAY=localhost:0.0
ENV GTK_IM_MODULE=fcitx
ENV QT_IM_MODULE=fcitx
ENV XMODIFIERS=@im=fcitx
ENV DefaultIMModule=fcitx
