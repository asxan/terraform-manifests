variable "project_id" {
  type        = string
  description = "GCP project id"
  default     = "asxan-project"
}

variable "eu-region" {
  type        = string
  description = "Europe Region"
  default     = "europe-west3"
}

variable "us-region" {
  type        = string
  description = "Europe Region"
  default     = "us-central1"
}

variable "image" {
  type        = string
  description = "Image for instance"
  default     = "centos-stream-9-v20240515"
}

variable "image-family" {
  type        = string
  description = "Image family"
  default     = "centos-stream-9"
}