terraform {
  backend "gcs" {
    bucket = "igsr5-terraform"
  }
}

provider "google" {
  project = "igsr5"
  zone    = "asia-northeast1-a"
}
