FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add strongswan && \
    rm -rf /var/cache/apk/*

RUN echo -e "net.ipv4.ip_forward=1\n\
net.ipv4.conf.all.accept_redirects = 0\n\
net.ipv4.conf.all.send_redirects = 0\n\
net.ipv6.conf.all.forwarding=1\n\
net.ipv6.conf.all.accept_redirects = 0\n\
net.ipv6.conf.all.send_redirects = 0" >> /etc/sysctl.conf

RUN copy pki/cacerts/* /etc/ipsec.d/cacerts/ && \
    copy pki/certs/* /etc/ipsec.d/certs/ && \
    copy pki/private/* /etc/ipsec.d/private/ && \
    copy config/ipsec.conf /etc/ipsec.conf && \
    copy config/ipsec.secrets /etc/ipsec.secrets

EXPOSE 500/udp 4500/udp

ENTRYPOINT ["/usr/sbin/ipsec"]]
CMD ["start", "--nofork"]


