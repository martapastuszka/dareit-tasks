terraform {
    required_version = ">= 4.60.2"
    backend "gcs" {
        bucket = "task8-static-website"
        prefix = "dev"
    }
}

required_providers {
    google = {
        source = "hashicorp/google"
        version = "v4.60.2"
    }
}