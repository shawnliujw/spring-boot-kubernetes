#!/usr/bin/env bash
cd employee-service
docker build -t registry-vpc.cn-hangzhou.aliyuncs.com/shawn_private/employee:1.1 . && docker push registry-vpc.cn-hangzhou.aliyuncs.com/shawn_private/employee:1.1 && cd ../
cd department-service
docker build -t registry-vpc.cn-hangzhou.aliyuncs.com/shawn_private/department:1.1 . && docker push registry-vpc.cn-hangzhou.aliyuncs.com/shawn_private/department:1.1 && cd ../
cd organization-service
docker build -t registry-vpc.cn-hangzhou.aliyuncs.com/shawn_private/organization:1.1 . && docker push registry-vpc.cn-hangzhou.aliyuncs.com/shawn_private/organization:1.1