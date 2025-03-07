FROM debian:sid

WORKDIR /home

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y openjdk-8-jdk:i386 wget git

COPY sun_java_wireless_toolkit-2.5.2_01-linuxi486.bin.sh /home/sun_java_wireless_toolkit-2.5.2_01-linuxi486.bin.sh

# Taken from https://github.com/eugeneandrienko/palm-dev-env-docker/blob/master/scripts/hack-wtk-installer.sh
RUN sed -ri -e 's/more <<"EOF"/cat <<  EOF/g' \
            -e 's/^agreed=/agreed=1/g' \
            -e 's/^  picked=/ picked=1/g' \
            -e 's/^    read picked/   \#read picked/g' \
            -e 's/^      read user_dir/         user_dir=0/g' \
            -e 's/^    read reply leftover/         reply=N       /g' \
            -e 's/^      read finish/         finish=0/g' \
            sun_java_wireless_toolkit-2.5.2_01-linuxi486.bin.sh && \
    sh ./sun_java_wireless_toolkit-2.5.2_01-linuxi486.bin.sh && \
    mv 0 WTK2.5.2

# Package not available on latest Debian release
RUN wget http://ftp.debian.org/debian/pool/main/p/prelink/execstack_0.0.20131005-1+b10_i386.deb && \
    dpkg -i execstack_0.0.20131005-1+b10_i386.deb && \
    execstack -c /home/WTK2.5.2/bin/libzayit.so

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-i386/
ENV WTK_HOME=/home/WTK2.5.2
