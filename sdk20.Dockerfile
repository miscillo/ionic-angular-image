FROM openjdk:8-jdk

ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/tools_r25.2.5-linux.zip" \
    ANDROID_BUILD_TOOLS_VERSION=27.0.0 \
    ANDROID_APIS="android-20" \
    GRADLE_HOME="/opt/gradle" \
    ANDROID_HOME="/opt/android" \
    PATH=/opt/node11/bin:/opt/android/tools:/opt/android/platform-tools:/opt/android/build-tools/27.0.0:/opt/gradle/gradle-5.0/bin:${PATH}

WORKDIR /opt

RUN echo Starting && \
#Install Node 11.10.0
    mkdir /opt/node11 && \
    curl -sL https://nodejs.org/dist/v11.10.0/node-v11.10.0-linux-x64.tar.gz | tar xz --strip-components=1 -C /opt/node11 && \

    # Installs Android SDK
    mkdir android && cd android && \
    wget -O tools.zip ${ANDROID_SDK_URL} && \
    unzip tools.zip && rm tools.zip && \
    export ANDROID_HOME=/opt/android && \
    echo y | /opt/android/tools/android update sdk -a -u -t platform-tools,${ANDROID_APIS},build-tools-27.0.0  && \
    #I don't know why, but it is needed
    echo y | /opt/android/tools/bin/sdkmanager "platforms;android-27" >/dev/null && \
    cd .. && \

    # Installs Gradle
    wget https://services.gradle.org/distributions/gradle-5.0-bin.zip -P /tmp &&\
    unzip -d /opt/gradle /tmp/gradle-*.zip && \
    export GRADLE_HOME=/opt/gradle/gradle-5.0 && \

    # Installs Node Stuff
    echo y |  npm install -g @angular/cli@8.0.1 ionic@5.0.1 cordova@9.0.0
