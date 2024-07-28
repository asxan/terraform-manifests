packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "1.1.4"
    }
    #    ansible = {
    #      source  = "github.com/hashicorp/ansible"
    #      version = "1.1.1"
    #    }
  }
}

variable "project_id" {
  type        = string
  description = "The project id for which will be created image"
  default     = "asxan-project"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone"
  default     = "europe-west3-a"
}

variable "source_image" {
  type        = string
  description = "The source image for building"
  default     = "centos-stream-9-v20240515"
}

variable "image_family" {
  type        = string
  description = "The source image for building"
  default     = "centos-stream-9"
}

variable "ssh_user" {
  type        = string
  description = "SSH user"
  default     = "asxan_agrail"
}

# I think it's more better to install jenkins and nginx on the same VM.
source "googlecompute" "nginx-reverse-jenkins" {
  project_id          = "${var.project_id}"
  zone                = "${var.availability_zone}"
  source_image        = "${var.source_image}"
  source_image_family = "${var.image_family}"
  ssh_username        = "${var.ssh_user}"
  image_name          = "nginx-reverse-jenkins"
  image_description   = "The Centos 9 Nginx host gce image for reversing traffic to Jenkins"
}

build {
  sources = ["source.googlecompute.nginx-reverse-jenkins"]

  provisioner "file" {
    source      = "easyio.asxan.fun.tar.gz"
    destination = "/tmp/easyio.asxan.fun.tar.gz"
  }

  provisioner "file" {
    source      = "jenkins.conf"
    destination = "/tmp/jenkins.conf"
  }

  provisioner "shell" {
    script = "setup-nginx-reverse-jenkins.sh"
  }

  post-processors {
    post-processor "checksum" {
      checksum_types = ["sha1", "sha256"]
      output         = "packer_{{.BuildName}}_{{.ChecksumType}}.checksum"
    }
  }
}