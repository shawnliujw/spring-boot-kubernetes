#!/usr/bin/env bash

telepresence \
    --mount /tmp/known \
    --swap-deployment employee \
    --docker-run \
    --rm \
    -v $(pwd):/build \
    -v $HOME/.m2/repository:/m3 \
    -v=/tmp/known/var/run/secrets:/var/run/secrets \
    -p 8080:8080 \
    maven:3.6-jdk-8-alpine \
        mvn \
            Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n" \
            -Dmaven.repo.local=/m3 \
            -f /build \
            spring-boot:run