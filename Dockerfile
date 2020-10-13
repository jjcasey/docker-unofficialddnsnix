FROM debian:buster AS build
RUN echo 'Acquire::http { Proxy "http://apt-cacher-ng:3142"; };' >> /etc/apt/apt.conf.d/01proxy

RUN apt-get update && apt-get -y --no-install-recommends install wget unzip python python2
RUN ln -s /usr/bin/python2 /usr/bin/python2.6

WORKDIR /build
RUN wget --no-check-certificate -O master.zip https://github.com/Robpol86/UnofficialDDNSnix/archive/master.zip
RUN unzip master.zip
WORKDIR UnofficialDDNSnix-master
RUN bash build_deb.sh

FROM debian:buster
RUN echo 'Acquire::http { Proxy "http://apt-cacher-ng:3142"; };' >> /etc/apt/apt.conf.d/01proxy
COPY --from=build /build/UnofficialDDNSnix-master/unofficialddns_1.0.0_all.deb unofficialddns_1.0.0_all.deb

COPY setup/ /usr/local/debian-base-setup/
RUN /usr/local/debian-base-setup/040-unofficialddns

CMD /usr/share/UnofficialDDNS/UnofficialDDNS.py -c /etc/UnofficialDDNS.yaml
