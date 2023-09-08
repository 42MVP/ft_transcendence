#!/bin/bash

IP_ADDRESS=$(ipconfig getifaddr en0)

sed -i '' "s|VITE_APP_API_URL=.*|VITE_APP_API_URL=http://$IP_ADDRESS:3000|" frontend/.env
sed -i '' "s|FRONTEND_URI = .*|FRONTEND_URI = http://$IP_ADDRESS:5173|" backend/.env
sed -i '' "s|42API_REDIRECT_URI = .*|42API_REDIRECT_URI = http://$IP_ADDRESS:3000/login/redirect|" backend/.env

echo "VITE_APP_API_URL updated to http://$IP_ADDRESS:3000"
