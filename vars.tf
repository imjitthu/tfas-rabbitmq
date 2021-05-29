variable "INSTANCE_TYPE" {
    default = ""
}

variable "DOMAIN" {default = ""}

variable "COMPONENT" {}

variable "env" {}
variable "ERLANG" {
    default = "http://packages.erlang-solutions.com/erlang/rpm/centos/7/x86_64/esl-erlang_23.2.3-1~centos~7_amd64.rpm"
}
variable "RABBITMQ" {
    default = "https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh"
}

