terraform {
  backend "http" {}
  required_providers {
    slack = {
      source  = "figma/slack"
      version = "~> 1.3.2"
    }
  }
  required_version = ">= 1.0.0"
}

provider "slack" {
}


# Ausgaben die beim ausführen von `terraform apply` anzeigt welcher Benutzer in welche Gruppe kommt.:
output "users_in_all_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "all") }
}

output "users_in_ceo_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "ceo") }
}

output "users_in_executive_management_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "executive_management") }
}

output "users_in_management_board_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "management_board") }
}

output "users_in_project_management_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "project_management") }
}

output "users_in_technical_management_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "technical_management") }
}

output "users_in_it_admins_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "it_admins") }
}

output "users_in_technical_team_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "technical_team") }
}

output "users_in_senior_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "senior") }
}

output "users_in_junior_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "junior") }
}

output "users_in_working_student_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "working_student") }
}

output "users_in_azubi_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "azubi") }
}

output "users_in_ausbilder_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "ausbilder") }
}

output "users_in_project_team_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "project_team") }
}

output "users_in_developers_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "developers") }
}

output "users_in_administration_team_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "administration_team") }
}

output "users_in_hr_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "hr") }
}

output "users_in_buchhaltung_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "buchhaltung") }
}

output "users_in_sipgate_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "sipgate") }
}

output "users_in_marketing_team_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "marketing_team") }
}

output "users_in_externe_group" {
  value = { for user, details in local.users : user => data.slack_user.users[user].id if contains(details.roles, "externe") }
}
