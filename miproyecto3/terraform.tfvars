virginia_cidr = "10.1.0.0/16"
#public_subnet = "10.1.0.0/24"
#private_subnet = "10.1.1.0/24"

subnets = ["10.1.0.0/24", "10.1.1.0/24"]

tags = {
  "env"         = "dev"
  "owner"       = "Santiago"
  "cloud"       = "AWS"
  "IAC"         = "Terraform"
  "IAC_Version" = "1.7.0"
  "project"     = "cerberus"
  "region"      = "virginia"
}

sg_ingress_cidr = "0.0.0.0/0"

#Linux AMI
ec2_specs = {
  "ami"           = "ami-07caf09b362be10b8"
  "instance_type" = "t2.micro"
}

#enable_monitoring = false
enable_monitoring = 0

ingress_ports_list = [22, 80, 443]