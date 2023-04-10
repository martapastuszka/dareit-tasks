# Make bucket public
resource "google_storage_bucket_iam_member" "member" {
  provider = google
  bucket   = "task8-static-website"
  role     = "roles/storage.objectViewer"
  member   = "allUsers"
}

# Create a bucket
resource "google_storage_bucket" "static-site" {
  name          = "task8-static-website"
  location      = "EU"
  force_destroy = true
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  cors {
    origin          = ["http://image-store.com"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}

# Create a VM
resource "google_compute_instance" "task8-vm" {
  name         = "task8-vm-tf"
  machine_type = "e2-medium"
  zone         = "europe-central2-b"

  tags = ["dareit"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
         managed_by_terraform = "true"
      }
    }
  }

  network_interface {
    network = "default"
    access_config {

      // Ephemeral public IP

    }
  }
}
