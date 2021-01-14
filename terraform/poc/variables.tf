# main creds for AWS connection
# variable "aws_access_key_id" {
#   description = "AWS access key"
# }

# variable "aws_secret_access_key" {
#   description = "AWS secret access key"
# }

variable "region" {
  description = "AWS region"
}


########################### Autoscale Config ################################

variable "max_instance_size" {
  description = "Maximum number of instances in the cluster"
}

variable "min_instance_size" {
  description = "Minimum number of instances in the cluster"
}

variable "desired_capacity" {
  description = "Desired number of instances in the cluster"
}
############################# common ########################################
variable "service" {
  description = "name of application"
}

variable "environment" {
  description = "environment of application"
}

variable "secondary_availability_zone" {
  
}
variable "availability_zone" {
  
}

variable "keypair" {
  
}