
if [ "$USER" == "guillaume" ]; then
    echo "Hello guillaume!"
    source backend/venValide/bin/activate
    echo "venv activated"
    code . &
    sudo systemctl enable docker --now
    echo "docker service launched"
    sudo docker compose up -d
    echo "supertokens and postgresql dockers running" 

else
    echo "Hello $USER"
    source backend/venValide/bin/activate
    sudo docker compose up -d
fi
