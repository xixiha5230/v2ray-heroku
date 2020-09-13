#!/bin/sh

mkdir /tmp
cd /tmp
git clone https://github.com/xixiha5230/web-heroku.git
install -m 755 /tmp/web-heroku/web /usr/local/bin/web
install -m 755 /tmp/web-heroku/subweb /usr/local/bin/subweb

# Remove temporary directory
rm -rf /tmp/web-heroku

install -d /usr/local/etc/web
cat << EOF > /usr/local/etc/web/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID",
                        "alterId": 64
                    }
                ],
                "disableInsecureEncryption": true
            },
            "streamSettings": {
                "network": "ws",
                "path": "$WS-PATH",
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

# Run web
/usr/local/bin/web -config /usr/local/etc/web/config.json
