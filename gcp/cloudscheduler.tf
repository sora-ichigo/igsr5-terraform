/*
 * attendance_request_bot
 * 友人に毎週月曜日に講義の出席を依頼するボット
 */
// NOTE: なぜかterrform管理から抜けていたので手動管理に移行した
// resource "google_cloud_scheduler_job" "attendance_request_bot" {
//   name             = "attendance-request-bot"
//   description      = "Sends a message to the attendance-request-bot channel"
//   schedule         = "45 10 * * 1"
//   time_zone        = "Asia/Tokyo"
//   attempt_deadline = "600s"
// 
//   retry_config {
//     retry_count = 3
//   }
// 
//   http_target {
//     http_method = "POST"
//     uri         = google_cloud_run_service.attendance_request_bot.status[0].url
// 
//     oidc_token {
//       audience              = google_cloud_run_service.attendance_request_bot.status[0].url
//       service_account_email = google_service_account.attendance_request_scheduler_sa.email
//     }
//   }
// }

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
    retry_count = 3
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
