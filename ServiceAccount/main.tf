resource "google_project_iam_custom_role" "my_role" {
  role_id = var.roleName
  title = var.title
  permissions = var.permissions
}

resource "google_service_account" "project_service_account" {
  account_id = var.serviceName
  project = var.project
}

resource "google_project_iam_binding" "sa_role" {
  project = var.project
  role    = "projects/${google_service_account.project_service_account.project}/roles/${google_project_iam_custom_role.my_role.role_id}"
  members = [
    "serviceAccount:${google_service_account.project_service_account.email}"
  ]
}