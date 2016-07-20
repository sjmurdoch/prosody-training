FROM prosody/prosody
MAINTAINER Steven Murdoch <s.murdoch@ucl.ac.uk>

RUN apt-get update && apt-get install -y patch && rm -rf /var/lib/apt/lists/*

COPY ./patches/extra-logging.patch /tmp
COPY entrypoint.sh /data
RUN patch -p1 -d /usr/lib/prosody < /tmp/extra-logging.patch

VOLUME ["/var/log/prosody", "/etc/prosody"]
EXPOSE 80 443 5222 5269 5347 5280 5281

CMD ["prosodyctl", "start"]
ENTRYPOINT ["/data/entrypoint.sh"]
