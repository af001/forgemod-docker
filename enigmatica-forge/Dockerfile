FROM alpine:latest as builder

# Update
RUN apk add --no-cache --virtual .build-deps                        \
    wget                                                            \
    openjdk8-jre-base                                               && \
    mkdir -p /opt/enigmatica

WORKDIR /opt/enigmatica

RUN wget -q https://edge.forgecdn.net/files/3058/671/Enigmatica6Server-0.2.17.zip    && \
    unzip Enigmatica6Server-0.2.17.zip                                     && \
    rm -f /opt/enigmatica/Enigmatica6Server-0.2.17.zip                                && \
    wget -q https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.16.1-32.0.108/forge-1.16.1-32.0.108-installer.jar -O installer.jar && \
    java -jar installer.jar --installServer && \
    rm -rf installer.jar 
    
COPY server.properties /opt/enigmatica
COPY eula.txt /opt/enigmatica

EXPOSE 32510 32511

CMD cd /opt/enigmatica && java -jar -Xms1G -Xmx4G -d64 -server -XX:+AggressiveOpts -XX:+UseConcMarkSweepGC -XX:+UnlockExperimentalVMOptions -XX:+UseParNewGC -XX:+ExplicitGCInvokesConcurrent -XX:+UseFastAccessorMethods -XX:+OptimizeStringConcat -XX:+UseAdaptiveGCBoundary forge-1.16.1-32.0.108.jar nogui
