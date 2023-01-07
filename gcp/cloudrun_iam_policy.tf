data "google_iam_policy" "igsr5_daily_cloud_run" {
  binding {
    role = "roles/admin"
    members = [
      "serviceAccount:823570656707-compute@developer.gserviceaccount.com",
    ]
  }

}

