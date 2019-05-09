#!/usr/bin/env bash
cd employee-service
docker build -t registry.cn-hangzhou.aliyuncs.com/shawn_repo/employee:1.1 .  && cd ../
cd department-service
docker build -t registry.cn-hangzhou.aliyuncs.com/shawn_repo/department:1.1 . && cd ../
cd organization-service
docker build -t registry.cn-hangzhou.aliyuncs.com/shawn_repo/organization:1.1 .