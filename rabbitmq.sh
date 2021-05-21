systemctl daemon-reload
systemctl enable rabbitmq-server
systemctl restart rabbitmq-server

rabbitmqctl add_user roboshop roboshop123; rabbitmqctl set_user_tags roboshop administrator; rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

systemctl restart rabbitmq-server


