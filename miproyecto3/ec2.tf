variable "instances" {
  description = "Nombre de Instancias"
  type        = set(string)
  default     = ["apache"]
}

# resource "aws_instance" "public_instance" {
#   count = length(var.instances)
#   ami                     = var.ec2_specs.ami
#   instance_type           = var.ec2_specs.instance_type
#   subnet_id = aws_subnet.public_subnet.id
#   key_name = data.aws_key_pair.key.key_name
#   vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
#   user_data = file("scripts/userdata.sh") 

#   tags = {
#     "Name" = var.instances[count.index]  #VER VIDEO 41 (TOSET) Y DEMAS
#   }

# }

resource "aws_instance" "public_instance" {
  for_each               = toset(var.instances)
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")

  tags = {
    "Name" = "${each.value}-${local.sufix}"
  }
}

resource "aws_instance" "mnitoring_instance" {
  #count = var.enable_monitoring ? 1:0
  count                  = var.enable_monitoring == 1 ? 1 : 0
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")

  tags = {
    "Name" = "Monitoreo-${local.sufix}"
  }


}

