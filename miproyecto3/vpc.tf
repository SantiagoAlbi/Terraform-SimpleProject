resource "aws_vpc" "virginia_vpc2" {
  cidr_block = var.virginia_cidr
  #instance_tenancy = "default"

  tags = {
    Name = "main virginia2-${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.virginia_vpc2.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public subnet-${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.virginia_vpc2.id
  cidr_block = var.subnets[1]

  tags = {
    Name = "Private subnet-${local.sufix}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.virginia_vpc2.id

  tags = {
    Name = "Internet gw virginia2-${local.sufix}"
  }
}

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.virginia_vpc2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  #route {
  # ipv6_cidr_block        = "::/0"
  # egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
  #}

  tags = {
    Name = "Public crt-${local.sufix}"
  }
}

resource "aws_route_table_association" "crt_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

#ver grupos de seguridad

resource "aws_security_group" "sg_public_instance" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.virginia_vpc2.id

  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Public Instance SG-${local.sufix}"

    #"tags = {
    # Name = "allow_tls"
    #}
  }
}

# module "mybucket" {
#   source      = "./modulos/s3"
#   bucket_name = "practicaterraviejajonny"
# }

#hacer utput practica modulos 1

output "s3_arn" {
  value = module.mybucket.s3_bucket_arn
}

module "terraform_state_backend" {
  source = "cloudposse/tfstate-backend/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version   = "1.4.1"
  namespace = "example"
  stage     = "prod"
  name      = "terraform"
  #environment = "us-east-1"
  attributes = ["state"]

  terraform_backend_config_file_path = "."
  terraform_backend_config_file_name = "backend.tf"
  force_destroy                      = false
}