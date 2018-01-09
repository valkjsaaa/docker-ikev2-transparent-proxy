ENV redirect_host 172.17.0.1:8107

FROM ubuntu:15.10

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install strongswan iptables uuid-runtime \
    && rm -rf /var/lib/apt/lists/* # cache busted 20151128.1

RUN rm /etc/ipsec.secrets

ADD ./etc/* /etc/
ADD ./bin/* /usr/bin/

VOLUME /etc

# http://blogs.technet.com/b/rrasblog/archive/2006/06/14/which-ports-to-unblock-for-vpn-traffic-to-pass-through.aspx
EXPOSE 500/udp 4500/udp

CMD /usr/bin/start-vpn ${redirect_host}
