FROM linuxserver/code-server

RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y\
        make \
        openjdk-11-jdk-headless \
        g++ \
        gcc \
        python3 \
        python3-pip \
        bsdtar \
        curl
        
RUN mkdir /config/workspace

run mkdir /ext
COPY ./*.vsix /ext/
RUN code-server --install-extension /ext/*.vsix

RUN chmod u-rwx -R /config
RUN chmod a-rwx -R /config
RUN chmod g-rwx -R /config
run chmod u+rwx -R /config/workspace
