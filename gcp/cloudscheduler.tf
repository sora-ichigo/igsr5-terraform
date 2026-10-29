/*
 * attendance_request_bot
 * 友人に毎週月曜日に講義の出席を依頼するボット
 */

/*
 * igsr5_daily
 * igsr5の日報アプリ
 *
 * 毎日18時にSlackで日報作成を促す
 */
resource "google_cloud_scheduler_job" "igsr5_daily" {
  name             = "igsr5-daily"
  schedule         = "0 19 * * *"
  time_zone        = "Asia/Tokyo"
  attempt_deadline = "600s"

  retry_config {
    retry_count = 1
  }

  http_target {
    http_method = "POST"
    uri         = format("%s%s", google_cloud_run_service.igsr5_daily.status[0].url, "/prompt_daily_report")

    oidc_token {
      audience              = google_cloud_run_service.attendance_request_bot.status[0].url
      service_account_email = google_service_account.attendance_request_scheduler_sa.email
    }
  }
}
