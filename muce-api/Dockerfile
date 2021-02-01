FROM ubuntu

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
        openjdk-11-jre-headless \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /opt/muce/
COPY MuceAPI-all.jar /opt/muce

CMD ["java", "-jar", "/opt/muce/MuceAPI-all.jar", "-Dspring.config.location=classpath:application.properties"]

EXPOSE 8080
