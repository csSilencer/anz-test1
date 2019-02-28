FROM openjdk:9-jdk-slim as build

COPY certificates /usr/local/share/ca-certificates/certificates

RUN apt-get update && apt-get install --no-install-recommends -y -qq ca-certificates-java

RUN update-ca-certificates 
#&& \
#chmod -R 777 /etc/ssl/certs && chmod 666 /etc/default/cacerts

RUN keytool -import -alias selfrest -storepass password123 -noprompt -keystore "${JAVA_HOME}/lib/security/anz-certs" -file /usr/local/share/ca-certificates/certificates/selfsigned.cer

FROM openjdk:9-jdk-slim as run

COPY --from=build /etc/ssl/certs /etc/ssl/certs
COPY --from=build /etc/default/cacerts /etc/default/cacerts

RUN groupadd --gid 1000 java &&\
useradd --uid 1000 --gid java --shell /bin/bash --create-home java && \
chmod -R a+w /home/java

COPY --from=build --chown=java:java ${JAVA_HOME}/lib/security/anz-certs ${JAVA_HOME}/lib/security/anz-certs

USER java
WORKDIR /home/java

