FROM alpine

RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories

RUN apk update && apk add --no-cache curl wget unzip git bash python3 py3-pip \
    plasma elogind polkit-elogind x11vnc ppsspp chromium font-noto-cjk xvfb xvfb-run

RUN git clone --depth=1 --recursive https://github.com/novnc/noVNC /novnc

EXPOSE 6080

WORKDIR /root

CMD xvfb-run -f ~/.Xauthority plasma_session & \
    x11vnc -display :99 & \
    /novnc/utils/novnc_proxy --vnc localhost:5900
