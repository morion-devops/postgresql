############
# provider #
############
provider "google" {
  credentials = file("../credentials/.gcp-creds.json")

  project = "prefab-poetry-334607"
  region  = "europe-north1"
  zone    = "europe-north1-a"
}

#############
# variables #
#############
variable "ssh_key_file_name" {
  default = "../credentials/.gcp_ssh.pub"
}

variable "ssh_user_name" {
  default = "gcp_postgres"
}

#############
# instances #
#############
resource "google_compute_instance" "postgres-master" {
  name         = "postgres-master"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      type  = "pd-standard"
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user_name}:${file(var.ssh_key_file_name)}"
  }

  labels = {
    service_name = "postgres"
    service_role = "master"
  }

  tags = ["postgres"]

  network_interface {
    network = "default"
    access_config {
      nat_ip       = google_compute_address.postgres-master.address
      network_tier = "STANDARD"
    }
  }
}

resource "google_compute_instance" "postgres-node1" {
  name                      = "postgres-node1"
  machine_type              = "e2-micro"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      type  = "pd-standard"
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user_name}:${file(var.ssh_key_file_name)}"
  }

  labels = {
    service_name = "postgres"
    service_role = "node"
  }

  tags = ["postgres"]
  
  network_interface {
    network = "default"
    access_config {
      network_tier = "STANDARD"
    }
  }
}


#########
# rules #
#########
resource "google_compute_firewall" "allow-posgtres" {
  name    = "allow-posgtres"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }
  target_tags   = ["postgres"]
  source_ranges = ["0.0.0.0/0"]
}

#############
# addresses #
#############
resource "google_compute_address" "postgres-master" {
  region       = "europe-north1"
  name         = "postgres-master"
  address_type = "EXTERNAL"
  network_tier = "STANDARD"
}
