#!/bin/bash
set -euxo pipefail

dnf install -y docker
systemctl enable --now docker

aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 423687458505.dkr.ecr.ap-southeast-1.amazonaws.com
docker pull 423687458505.dkr.ecr.ap-southeast-1.amazonaws.com/aws-infra-practice-app:latest

cat > /etc/systemd/system/aws-infra-practice-app.service <<'EOF'
[Unit]
Description=API Container
After=docker.service
Requires=docker.service

[Service]
Restart=always
ExecStartPre=-/usr/bin/docker rm -f aws-infra-practice-app
ExecStart=/usr/bin/docker run --name aws-infra-practice-app -p 4000:4000 -e JWT_SECRET=emoa1231kn92198kn129h312oj3o1 -e DB_SSL=true -e DB_HOST=${db_host} -e DB_NAME=${db_name} -e DB_USERNAME=${db_username} -e DB_PASSWORD=${db_password} 423687458505.dkr.ecr.ap-southeast-1.amazonaws.com/aws-infra-practice-app:latest

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now aws-infra-practice-app