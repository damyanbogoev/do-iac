#!/usr/bin/env bash
LOCAL_IP=`ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | grep 'addr:10.' | cut -d: -f2 | awk '{ print $1}'`
PUBLIC_IP=`curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'`
DOMAIN_NAME=`dnsdomainname`

ARPA_ADDR=`echo $LOCAL_IP | awk 'BEGIN{FS="."}{print $2"."$1".in-addr.arpa"}'`
NETWORK=`echo $LOCAL_IP | awk 'BEGIN{FS="."}{print $1"."$2".0.0/16"}'`

# patching the pdns recursor configuration file
sed -i "s|allow-from=.*|allow-from=$NETWORK|" /etc/powerdns/recursor.conf
sed -i "s|local-address=.*|local-address=$LOCAL_IP|" /etc/powerdns/recursor.conf
sed -i "s|forward-zones=.*|forward-zones=$DOMAIN_NAME=127.0.0.1:5300,$ARPA_ADDR=127.0.0.1:5300|" /etc/powerdns/recursor.conf

# patching the pdns server configuration file
sed -i "s|# api=.*|api=yes|" /etc/powerdns/pdns.conf
sed -i "s|# webserver=.*|webserver=yes|" /etc/powerdns/pdns.conf
sed -i "s|# webserver-address=.*|webserver-address=$PUBLIC_IP|" /etc/powerdns/pdns.conf
sed -i "s|# webserver-allow-from=.*|webserver-allow-from=0.0.0.0/0,::/0|" /etc/powerdns/pdns.conf

pdnsutil create-zone $DOMAIN_NAME ns1.$DOMAIN_NAME
pdnsutil create-zone $ARPA_ADDR