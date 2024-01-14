FROM i386/debian:12.4-slim

# 1) INSTALL BASICS
RUN apt-get update && apt-get install -y wget libc6 libstdc++6 --force-yes

# 2) Create user
RUN groupadd -r hlds
RUN useradd --no-log-init --system --create-home --home-dir /server --gid hlds  hlds
USER hlds

# 3) Install HLDS 3.1.1.1 and 3.1.1.e
RUN wget -q -O -  http://eisbaer.essentrix.net/halflife/hl_linux/hlds_l3104.tar.gz | tar -xzf - -C /server
RUN wget -q -O - http://eisbaer.essentrix.net/halflife/hl_linux/hlds_l.3104.nowon.tar.gz | tar -xzf - -C /server/hlds_l

WORKDIR /server/hlds_l/

#Install WON2 masterserver and modified HLDS_RUN
USER root

COPY ./install/hlds_start /server/hlds_l/hlds_start
COPY config/valve/* ./valve/*
RUN chmod +x hlds_run
RUN chmod +x hlds_start

# Then, remove default mod folders
RUN rm -rf ./tfc

USER hlds

# Expose required default ports
EXPOSE 27015
EXPOSE 27015/udp

ENV TERM xterm

ENTRYPOINT ["./hlds_start"]

CMD ["-game valve", "+map crossfire", "+maxplayers 16"]