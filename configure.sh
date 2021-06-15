#!/bin/sh

mkdir /tmp
cd /tmp
git clone https://github.com/xixiha5230/v2ray-heroku
install -m 755 /tmp/v2ray-heroku/v2ray /usr/local/bin/v2ray
install -m 755 /tmp/v2ray-heroku/v2ctl /usr/local/bin/v2ctl

rm -rf /tmp/v2ray-heroku

install -d /usr/local/etc/v2ray
install -d /usr/local/etc/v2ctl

cat << EOF > /usr/local/etc/v2ray/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID",
                        "level": 0
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "wsSettings": {
                    "path": "$WSPATH"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

/usr/local/bin/v2ray -config /usr/local/etc/v2ray/config.json
rm /usr/local/etc/v2ray/config.json
