#!/bin/sh

mkdir /tmp
cd /tmp
git clone https://github.com/xixiha5230/web-heroku.git
install -m 755 /tmp/web-heroku/web /usr/local/bin/web

# Remove temporary directory
rm -rf /tmp/web-heroku

install -d /usr/local/etc/web
cat << EOF > /usr/local/etc/web/config.json
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
#cat /usr/local/etc/web/config.json
# Run web
/usr/local/bin/web -config /usr/local/etc/web/config.json
rm /usr/local/etc/web/config.json
