/*
 * 友人に毎週月曜日に講義の出席を依頼するボット
 */
resource "google_cloud_run_service" "attendance_request_bot" {
  name     = "attendance-request-bot"
  location = "asia-northeast1"

  template {
    spec {
      containers {
        // NOTE: This is temporary. This will be replaced with a container image.
        image = "us-docker.pkg.dev/cloudrun/container/hello"
      }
    }
  }

  lifecycle {
    ignore_changes = [template]
  }
}

