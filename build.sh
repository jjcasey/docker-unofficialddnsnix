#! /bin/sh
docker network create -d bridge lan-services || /bin/true
docker build --network lan-services -t unofficialddns .
