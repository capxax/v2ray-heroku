#!/bin/sh
# Download and install V2Ray
curl -L -H "Cache-Control: no-cache" -o /xray.zip https://github.com/XTLS/Xray-core/releases/download/v1.4.2/Xray-linux-64.zip
mkdir /usr/bin/xray /etc/xray
touch /etc/xray/config.json
unzip /xray.zip -d /usr/bin/xray
# Remove /v2ray.zip and other useless files
rm -rf /xray.zip /usr/bin/xray/*.sig /usr/bin/xray/doc /usr/bin/xray/*.json /usr/bin/xray/*.dat /usr/bin/xray/sys*
# V2Ray new configuration
cat <<-EOF > /etc/xray/config.json
{
  "inbounds": [
  {
    "port": ${PORT},
    "protocol": "vless",
    "settings": {
      "clients": [
        {
          "id": "${UUID}",
          "flow": "xtls-rprx-direct"
          
        }
      ]
    },
    "streamSettings": {
      "network": "ws"
    }
  }
  ],
  "outbounds": [
  {
    "protocol": "freedom",
    "settings": {}
  }
  ]
}
EOF
/usr/bin/xray/xray -config=/etc/xray/config.json
