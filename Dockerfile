FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y curl tar \
    coreutils \
    manpages-dev \
    xorg openbox \
    ncurses-dev \
    wget \
    vim \
    gcc clang make \
    gdb ddd \
    qemu

# Prepare the Pintos directory
COPY pintos /pintos
WORKDIR /pintos

ENV PATH=/pintos/src/utils:$PATH

# Fix ACPI bug
## Fix described here under "Troubleshooting": http://arpith.xyz/2016/01/getting-started-with-pintos/
RUN sed -i '/serial_flush ();/a \
  outw( 0x604, 0x0 | 0x2000 );' /pintos/src/devices/shutdown.c

RUN sed -i 's/bochs/qemu/' /pintos/*/*/Make.vars
RUN cd /pintos/src/threads && make
RUN sed -i 's/LDFLAGS/LDLIBS/' /pintos/src/utils/Makefile && \
    sed -i 's/\$sim = "bochs"/$sim = "qemu"/' /pintos/src/utils/pintos && \
    sed -i 's/kernel.bin/\/pintos\/threads\/build\/kernel.bin/' /pintos/src/utils/pintos && \
    sed -i "s/my (@cmd) = ('qemu');/my (@cmd) = ('qemu-system-x86_64');/" /pintos/src/utils/pintos && \
    sed -i 's/loader.bin/\/pintos\/threads\/build\/loader.bin/' /pintos/src/utils/Pintos.pm

CMD ["sleep", "infinity"]