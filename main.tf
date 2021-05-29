locals {
  key_name = "test"
  key_path = "test.pem"
}

resource "aws_instance" "rabbitmq" {
  ami = data.aws_ami.ami.id
  instance_type = "${var.INSTANCE_TYPE}"
  tags = {
    "Name" = "${var.COMPONENT}-${var.env}"
  }

connection {
  host = aws_instance.rabbitmq.public_ip
  type = "ssh"
  user = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)["SSH_USER"]
  password = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)["SSH_PASS"]
}

provisioner "file" {
    source      = "rabbitmq.sh"
    destination = "/tmp/rabbitmq.sh"
  }

provisioner "remote-exec" {
  inline = [ 
    "set-hostname ${var.COMPONENT}",
    "yum install ${var.ERLANG} -y",
    "curl -s ${var.RABBITMQ} | sudo bash",
    "yum install rabbitmq-server -y",
    "sh /tmp/rabbitmq.sh"
    ]
}

provisioner "local-exec" {
  command = "echo ${aws_instance.rabbitmq.public_ip} > rabbitmq_inv"
}
}

resource "aws_route53_record" "jithendar" {
  name          = "${var.COMPONENT}.${data.aws_route53_zone.jithendar.name}"
  type          = "A"
  ttl           = "300"
  zone_id       = data.aws_route53_zone.jithendar.zone_id
  records       = [aws_instance.rabbitmq.public_ip]
}
