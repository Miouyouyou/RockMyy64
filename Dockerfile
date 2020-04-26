FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN echo "UTC" > /etc/timezone

RUN apt -y update
RUN apt -y install gcc make automake bison flex bc pkg-config wget git ncurses-dev libssl-dev cpio rsync gcc-aarch64-linux-gnu

COPY GetPatchAndCompileKernel.sh /GetPatchAndCompileKernel.sh
COPY docker/build.sh /entrypoint.sh

VOLUME ["/git", "/tmp/RockMyy-Build"]

CMD ["/entrypoint.sh"]
