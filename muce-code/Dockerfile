FROM linuxserver/code-server

RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y\
        make \
        openjdk-11-jdk-headless \
        g++ \
        gcc \
        python3 \
        python3-pip \
        unzip \
        wget 
#Gradle
RUN mkdir /opt/gradle

RUN cd /opt/gradle && wget -O /opt/gradle/gradle-6.8.1-all.zip https://services.gradle.org/distributions/gradle-6.8.1-all.zip
RUN unzip -d /opt/gradle/ /opt/gradle/gradle-6.8.1-all.zip
RUN export PATH=$PATH:/opt/gradle/gradle-6.8.1/bin

RUN mkdir /config/workspace/

RUN mkdir /ext
COPY ./*.vsix /ext/

RUN code-server --install-extension /ext/ms-vscode.vscode-typescript-next-4.2.20210201.vsix
RUN code-server --install-extension /ext/richardwillis.vscode-gradle-3.5.2.vsix
RUN code-server --install-extension /ext/naco-siren.gradle-language-0.2.3.vsix
RUN code-server --install-extension /ext/ms-vscode.cpptools-1.1.3.vsix
RUN code-server --install-extension /ext/vscjava.vscode-java-pack-0.12.1.vsix
RUN code-server --install-extension /ext/vscjava.vscode-java-debug-0.30.0.vsix
RUN code-server --install-extension /ext/redhat.java-0.74.0.vsix
