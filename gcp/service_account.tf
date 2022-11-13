resource "google_service_account" "attendance_request_scheduler_sa" {
  account_id   = "cloud-run-invoker-sa"
  display_name = "Cloud Run Invoker Service Account"
}

data "google_iam_policy" "attendance_request_scheduler_sa_invoker" {
  binding {
    role = "roles/run.invoker"
    members = [
      "serviceAccount:${google_service_account.attendance_request_scheduler_sa.email}"
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "attendance_request_scheduler_sa_policy" {
  location    = google_cloud_run_service.attendance_request_bot.location
  service     = google_cloud_run_service.attendance_request_bot.name
  policy_data = data.google_iam_policy.attendance_request_scheduler_sa_invoker.policy_data
}
