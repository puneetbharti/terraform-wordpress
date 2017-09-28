provider "aws" {
    region = "${var.aws_region}"
}

resource "aws_instance" "nagios" {

  instance_type = "${var.instance_type}"

  ami = "${var.base_ami}"

  key_name = "${var.key_name}"

  count= "${var.num_instances}"

  subnet_id = "${var.subnets[count.index%2]}"

  vpc_security_group_ids = "${var.security_groups}"

  monitoring = true

  tags {
    "Name" = "${var.cluster_vertical}${var.cluster_app}.${var.route53_zone}"
    "Vertical" = "${var.cluster_vertical}"
    "App" ="${var.cluster_app}"
    "Role" = "${var.cluster_role}"
    "Cluster" = "${var.cluster_vertical}-${var.cluster_app}"
  }
}

resource "aws_route53_record" "nagios" {
  count = "${var.num_instances}"
  zone_id = "${var.route53_zone_id}"
  name = "${var.cluster_vertical}${var.cluster_app}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.nagios.*.public_ip, count.index)}"]
}



resource "null_resource" "nagios" {
  triggers {
    cluster_instance_ids = "${join(",", aws_instance.nagios.*.id)}"
  }
  triggers {
    cluster_instance_ids = "${join(",", aws_route53_record.nagios.*.id)}"
  }
  provisioner "local-exec" {
    command = "echo '[local]\n localhost\n [all:vars]\n ansible_ssh_user=ubuntu \n ansible_ssh_private_key_file=~/.ssh/${var.key_name}.pem \n [${var.cluster_vertical}]' > ${path.module}/../ansible/inventories/${var.cluster_vertical}_${var.cluster_app}.ini"
  }

  provisioner "local-exec" {
    command = "echo ${var.cluster_vertical}${var.cluster_app}.${var.route53_zone} >> ${path.module}/../ansible/inventories/${var.cluster_vertical}_${var.cluster_app}.ini"
  }

   provisioner "local-exec" {
    command = "cd ${path.module}/../ansible/ && ansible-playbook -e ANSIBLE_HOST_KEY_CHECKING=False -i inventories/${var.cluster_vertical}_${var.cluster_app}.ini monitor.yml --extra-vars='hosts=${var.cluster_vertical} vertical_name=${var.cluster_vertical}'"
  }
}



terraform {
  backend "s3" {
    bucket = "tfwp"
    key    = "staging/service/nagios/terraform.tfstate"
    region = "ap-south-1"
  }
}