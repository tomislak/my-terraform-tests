variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "resource_ami_amazonLinux2" {
  description = "AMI for Amazon Linux 2"
  type        = string
  default     = "ami-0bad4a5e987bdebde"
}

variable "resource_ami_ubuntuLinux2004" {
  description = "AMI for Ubuntu Linux 20.04"
  type        = string
  default     = "ami-05f7491af5eef733a"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "instance_count" {
  description = "Number of app server instances"
  type        = number
  default     = 2
}

variable "app_server_instance_name" {
  description = "Value of the Name tag for the EC2 app_server instance"
  type        = string
  default     = "AppServer"
}

variable "environment" {
  description = "sort of environment"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Name of environment"
  type        = string
  default     = "testProject1"
}

