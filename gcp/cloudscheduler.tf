resource "google_cloud_scheduler_job" "attendance_request_bot" {
  name             = "attendance-request-bot"
  description      = "Sends a message to the attendance-request-bot channel"
  schedule         = "9 45 * * 1"
  time_zone        = "Asia/Tokyo"
  attempt_deadline = "600s"

  retry_config {
    retry_count = 3
  }

  http_target {
    http_method = "POST"
    uri         = google_cloud_run_service.attendance_request_bot.status[0].url
  }
}
