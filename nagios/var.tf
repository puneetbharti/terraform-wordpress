//
// tags
// this is going to be used for tagging purpose
//

variable "num_instances" {
  default = 1
}

variable "cluster_app" {
  default = "nagios"
}

variable "cluster_vertical" {
  description = "The name to use for all the cluster resources"
  default = "grab"
}

variable "cluster_role" {
  description = "The name to use for all the cluster resources"
  default = "monitoring"
}



variable "instance_type" {
  default = "t2.nano"
}

variable "base_ami" {
  default = "ami-3c374c53"
}

variable "key_name" {
  default = "mywpkey"
}

variable "security_groups" {
  default = ["sg-0c45da64"]
}

//
// End of tags
//



variable "aws_region" {
  default = "ap-south-1"
}

//
// route 53 zones
variable "route53_zone" {
  default = "topmkt.net"
}

variable "route53_zone_id" {
  default = "Z3UP578CWT5IM1"
}
// End of route 53
//

// subnets
// we devide the number of instances into two subnet groups
// so we are configuring two subnets

variable "subnets" {
  default = ["subnet-823dd0eb","subnet-823dd0eb"]
}
