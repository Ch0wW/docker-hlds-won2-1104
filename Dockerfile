FROM i386/debian:12.4-slim

# 1) INSTALL BASICS
RUN apt-get update && apt-get install -y wget libc6 libstdc++6 --force-yes

# 2) Create user
RUN groupadd -r hlds
RUN useradd --no-log-init --system --create-home --home-dir /server --gid hlds  hlds
USER hlds

# 3) Install HLDS 3.1.0.4
RUN wget -q -O -  http://eisbaer.essentrix.net/halflife/hl_linux/hlds_l3104.tar.gz | tar -xzf - -C /server

WORKDIR /server/hlds_l/

#Install WON2 masterserver and modified HLDS_RUN
USER root

COPY ./install/hlds_start /server/hlds_l/hlds_start
COPY ./install/nowon.so /server/hlds_l/nowon.so

COPY config/valve/* ./valve/*
RUN chmod +x hlds_run
RUN chmod +x hlds_start

# Then, remove default mod folders
RUN rm -rf ./tfc

USER hlds

ENV TERM xterm

ENTRYPOINT ["./hlds_start"]

CMD ["-game valve", "+map crossfire", "+maxplayers 16"]