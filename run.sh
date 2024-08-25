
if [ "$USER" == "guillaume" ]; then
    echo "Hello guillaume!"
    source backend/venValide/bin/activate
    echo "venv activated"
    code . &
    sudo systemctl enable docker --now
    echo "docker service launched"
    sudo docker compose up -d
    echo "supertokens and postgresql dockers running"
    cd backend
    echo "enter secret main password"
    read password
    echo $password | python3 main.py &
    echo "backend running"

else
    echo "Hello $USER"
    source backend/venValide/bin/activate
    sudo docker compose up -d
fi
