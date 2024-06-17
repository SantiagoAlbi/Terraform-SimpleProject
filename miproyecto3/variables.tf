variable "virginia_cidr" {
  #default = "10.1.0.0/16"
  description = "CIDR Virginia"
  type        = string
  sensitive   = false
}

variable "subnets" {
  description = "Lista de subnets"
  type        = list(string)
}

variable "tags" {
  description = "tags del proyect"
  type        = map(string)
}

variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

variable "ec2_specs" {
  description = "Parametros de la Instancia"
  type        = map(string)
}

variable "enable_monitoring" {
  description = "Habilita el despliegue de un serividor de monitoreo"
  #type = bool
  type = number
}

variable "ingress_ports_list" {
  description = "Lista de puertos de Ingress"
  type        = list(number)
}