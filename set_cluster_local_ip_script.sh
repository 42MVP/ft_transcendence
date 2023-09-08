#!/bin/bash

IP_ADDRESS=$(ipconfig getifaddr en0)
FPORT="${1:-80}"
BPORT="${2:-3000}"

sed -i '' "s|VITE_APP_API_URL=.*|VITE_APP_API_URL=http://$IP_ADDRESS:$BPORT|" frontend/.env
if [ "$FPORT" -ne 80 ]; then
    sed -i '' "s|FRONTEND_URI = .*|FRONTEND_URI = http://$IP_ADDRESS:$FPORT|" backend/.env
else
    sed -i '' "s|FRONTEND_URI = .*|FRONTEND_URI = http://$IP_ADDRESS|" backend/.env
fi
sed -i '' "s|42API_REDIRECT_URI = .*|42API_REDIRECT_URI = http://$IP_ADDRESS:$BPORT/login/redirect|" backend/.env

echo "./set_cluster_local_ip_script.sh [frontend port] [backend port]"
echo "frontend endpoint updated to http://$IP_ADDRESS:$FPORT"
echo "backend endpoint updated to http://$IP_ADDRESS:$BPORT"
