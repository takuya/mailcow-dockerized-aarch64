## mailcow の設定で、v6を切っていく
## 参考資料:https://docs.mailcow.email/post_installation/firststeps-disable_ipv6/
### docker v6 networkで切る


dir=$( dirname $0)/../mailcow-dockerized
echo $dir
cd $dir


###############

sed -i 's|enable_ipv6: true|enable_ipv6: false|' docker-compose.yml
## ipv6natを切る。
touch docker-compose.override.yml
cat <<EOF | sudo tee docker-compose.override.yml
version: '2.1'
services:
    ipv6nat-mailcow:
      image: bash:latest
      restart: "no"
      entrypoint: ["echo", "ipv6nat disabled in compose.override.yml"]
EOF

### unboundにv6応答をやめさせる
sed -i 's|do-ip6: yes|do-ip6: no|'  data/conf/unbound/unbound.conf
sed -i '/do-ip6/s/$/\n  prefer-ip6: no/g' data/conf/unbound/unbound.conf
sed -i '/ipsecmod-enabled/s/$/\n  local-zone: ip6.arpa. refuse/g' data/conf/unbound/unbound.conf

### postfix にv6利用をやめさせる
cat <<EOF | sudo tee -a data/conf/postfix/extra.cf
smtp_address_preference = ipv4
inet_protocols = ipv4
EOF
### nginx /devecot / php-fpm にv6リッスンをやめさせる
sed -i '\|\[::\]:8081;|d' data/conf/nginx/dynmaps.conf
sed -i '\|::|d' data/conf/nginx/templates/listen*
sed -i 's/,\[::\]//g' data/conf/dovecot/dovecot.conf
sed -i 's/\[::\]://g' data/conf/phpfpm/php-fpm.d/pools.conf

