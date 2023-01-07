resource "google_secret_manager_secret" "igsr5_daily_database_url" {
  secret_id = "igsr5-daily--database-url"

  labels = {
    label = "igsr5-daily--database-url"
  }

  replication {
    user_managed {
      replicas {
        location = "asia-northeast1"
      }
    }
  }
}

resource "google_secret_manager_secret_iam_policy" "igsr5_daily_database_url" {
  project     = google_secret_manager_secret.igsr5_daily_database_url.project
  secret_id   = google_secret_manager_secret.igsr5_daily_database_url.secret_id
  policy_data = data.google_iam_policy.igsr5_daily_cloud_run.policy_data
}



resource "google_secret_manager_secret" "igsr5_daily_slack_bot_token" {
  secret_id = "igsr5-daily--slack-bot-token"

  labels = {
    label = "igsr5-daily--slack-bot-token"
  }

  replication {
    user_managed {
      replicas {
        location = "asia-northeast1"
      }
    }
  }
}
resource "google_secret_manager_secret_iam_policy" "igsr5_daily_slack_bot_token" {
  project     = google_secret_manager_secret.igsr5_daily_slack_bot_token.project
  secret_id   = google_secret_manager_secret.igsr5_daily_slack_bot_token.secret_id
  policy_data = data.google_iam_policy.igsr5_daily_cloud_run.policy_data
}



resource "google_secret_manager_secret" "igsr5-daily_slack_signing_secret" {
  secret_id = "igsr5-daily--slack-signing-secret"

  labels = {
    label = "igsr5-daily--slack-signing-secret"
  }

  replication {
    user_managed {
      replicas {
        location = "asia-northeast1"
      }
    }
  }
}

resource "google_secret_manager_secret_iam_policy" "igsr5_daily_slack_signing_secret" {
  project     = google_secret_manager_secret.igsr5-daily_slack_signing_secret.project
  secret_id   = google_secret_manager_secret.igsr5-daily_slack_signing_secret.secret_id
  policy_data = data.google_iam_policy.igsr5_daily_cloud_run.policy_data
}

resource "google_secret_manager_secret" "igsr5-daily_slack_admin_user_id" {
  secret_id = "igsr5-daily--slack-admin-user-id"

  labels = {
    label = "igsr5-daily--slack-admin-user-id"
  }

  replication {
    user_managed {
      replicas {
        location = "asia-northeast1"
      }
    }
  }
}
resource "google_secret_manager_secret_iam_policy" "igsr5_daily_slack_admin_user_id" {
  project     = google_secret_manager_secret.igsr5-daily_slack_admin_user_id.project
  secret_id   = google_secret_manager_secret.igsr5-daily_slack_admin_user_id.secret_id
  policy_data = data.google_iam_policy.igsr5_daily_cloud_run.policy_data
}


