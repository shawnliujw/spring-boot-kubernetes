#!/usr/bin/env bash

telepresence \
    --mount /tmp/known \
    --swap-deployment employee \
    --env-json tele_env.json \
    --docker-run \
    --rm \
    -v $(pwd):/build \
    -v $HOME/.m2/repository:/m3 \
    -v=/tmp/known/var/run/secrets:/var/run/secrets \
    -p 8080:8080 \
    -p 5005:5005 \
    -e MAVEN_OPTS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 \
    maven:3-jdk-8  \
        mvn \
            -Dmaven.repo.local=/m3 \
            -f /build \
            spring-boot:run