FROM alpine:latest as builder

# Update
RUN apk add --no-cache --virtual .build-deps                        \
    wget                                                            \
    openjdk8-jre-base                                               && \
    mkdir -p /opt/enigmatica

WORKDIR /opt/enigmatica

RUN wget -q https://edge.forgecdn.net/files/3058/671/Enigmatica6Server-0.2.17.zip    && \
    unzip Enigmatica6Server-0.2.17.zip                                               && \
    mv Enigmatica6Server-0.2.17 server                                               && \
    rm -f /opt/enigmatica/Enigmatica6Server-0.2.17.zip                                && \
    chmod 755 /opt/enigmatica/server/ServerStart.sh                                      && \
    mkdir {backups,tools}

COPY server.properties /opt/enigmatica/server
COPY eula.txt /opt/enigmatica/server

EXPOSE 32510 32511

CMD cd /opt/enigmatica/server && sh server-start.sh
