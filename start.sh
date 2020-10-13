#! /bin/sh
docker container rm unofficialddns || /bin/true
docker run -td \
	--restart always \
	-v ${PWD}/UnofficialDDNS.yaml:/etc/UnofficialDDNS.yaml:ro \
	--network lan-services \
	--name=unofficialddns \
	unofficialddns
