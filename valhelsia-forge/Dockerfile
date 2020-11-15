FROM alpine:latest as builder

# Update
RUN apk add --no-cache --virtual .build-deps                        \
    wget                                                            \
    openjdk8-jre-base                                               && \
    mkdir -p /opt/valhelsia

COPY Valhelsia_SERVER-pre5-3.1.0.zip /opt/valhelsia

WORKDIR /opt/valhelsia

RUN wget -q https://edge.forgecdn.net/files/3110/654/Valhelsia_SERVER-pre5-3.1.0.zip    && \
    unzip Valhelsia_SERVER-pre5-3.1.0.zip                                               && \
    mv Valhelsia_SERVER-pre5-3.1.0 server                                               && \
    rm -f /opt/valhelsia/Valhelsia_SERVER-pre5-3.1.0.zip                                && \
    chmod 755 /opt/valhelsia/server/ServerStart.sh                                      && \
    mkdir {backups,tools}

COPY server.properties /opt/valhelsia/server
COPY eula.txt /opt/valhelsia/server

EXPOSE 32500 32501

CMD cd /opt/valhelsia/server && java -jar -Xms1G -Xmx4G -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=50 -XX:+AlwaysPreTouch forge-1.16.3-34.1.42.jar nogui
