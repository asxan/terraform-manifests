variable "project_id" {
  type        = string
  description = "GCP project id"
  default     = "asxan-project"
}

variable "region" {
  type        = string
  description = "Region"
  default     = "europe-west3"
}

variable "image" {
  type        = string
  description = "Image for instance"
  default     = "nginx-centos-7"
}