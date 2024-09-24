# Idee ist es eine zentrale Benutzerliste zu haben und diese dynamisch den gruppen zu zu weisen

locals {
    # zentrale Benutzerliste mit Rolle für interne und externe

  users = {
    # interne user:
    "user.1"          = { email = "user.1@domain.com", roles = ["all", "ceo", "executive_management", "management_board", "it_admins", "buchhaltung", "sipgate", "marketing_team"] },
    "user.2"       = { email = "user.2@domain.com", roles = ["all", "executive_management", "management_board", "hr", "buchhaltung", "sipgate", "marketing_team", "administration_team"] },
    "user.3"      = { email = "user.3@domain.com", roles = ["all", "it_admins","technical_team", "junior", "azubi", "sipgate", "kunde1"] },
    "user.4"     = { email = "user.4@domain.com", roles = ["all", "it_admins","technical_team", "junior", "sipgate", "kunde1","kunde2"] },
    "user.5"         = { email = "user.5@domain.com", roles = ["all", "it_admins","technical_team", "senior", "project_team", "developers",] },
    "user.6"          = { email = "user.6@domain.com", roles = ["all", "it_admins","technical_team", "senior", "project_team", "developers", "kunde1", "kunde2"] },
    "user.7"          = { email = "user.7@domain.com", roles = ["all", "it_admins","technical_team", "senior", "project_team", "developers", "kunde1", "kunde2", "ausbilder"] },
    "user.8"      = { email = "user.8@domain.com", roles = ["all", "management_board", "it_admins", "technical_management", "technical_team", "senior", "project_team", "developers",] },
    "user.9"         = { email = "niclas.peyerl@domain.com", roles = ["all", "management_board", "project_management", "project_team", "developers", "sipgate", "kunde1", "kunde2"] },
    "user.10"        = { email = "user.10@domain.com", roles =["all", "technical_team", "working_student", "sipgate"] },
    "user.11"           = { email = "user.11@domain.com", roles = ["all", "technical_team", "azubi", "sipgate"] },
    "user.12"   = { email = "user.12@domain.com", roles = ["all", "management_board", "marketing_team"] },
    # externe user:
    "user.13" = { email = "user.13@domain.com", roles = ["externe", "marketing_team"] },
    // "user.14" = { email = "hallo@monika-sedivy.de", roles = ["externe", "marketing_team"] },
    "user.15" = { email = "user.15@domain.com", roles = ["externe", "marketing_team"] },
  }
}

# abruf der Benutzerinformationen anhand der zentralen Userliste
data "slack_user" "users" {
  for_each = local.users
  email    = each.value.email
}

# Dynamische Zuordnung der Benutzer zu Gruppen basierend ihrer Rolle:

locals {
    permanent_members_all = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "all")]
    permanent_members_ceo = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "ceo")]
    permanent_members_executive_management = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "executive_management")]
    permanent_members_management_board = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "management_board")]
    permanent_members_project_management = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "project_management")]
    permanent_members_technical_management = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "technical_management")]
    permanent_members_it_admins = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "it_admins")]
    permanent_members_technical_team = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "technical_team")]
    permanent_members_senior = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "senior")]
    permanent_members_junior = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "junior")]
    permanent_members_working_student = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "working_student")]
    permanent_members_azubi = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "azubi")]
    permanent_members_ausbilder = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "ausbilder")]
    permanent_members_project_team = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "project_team")]
    permanent_members_developers = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "developers")]
    permanent_members_administration_team = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "administration_team")]
    permanent_members_hr = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "hr")]
    permanent_members_buchhaltung = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "buchhaltung")]
    permanent_members_sipgate = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "sipgate")]
    permanent_members_marketing_team = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "marketing_team")]
    permanent_members_externe = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "externe")]
    permanent_members_kunde1 = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "kunde1")]
    permanent_members_kunde2 = [for user, details in local.users : data.slack_user.users[user].id if contains(details.roles, "kunde2")]
}

# Technische Variable für die Bot's. Diese wird separat gehalten, um eine klare Trennung zwischen Benutzergruppen und technischen IDs zu gewährleisten.

# abruf der bot-inforamtionen
data "slack_user" "terraform_bot" {
  name = "terraform"
}

# Dynamisches Abrufen der Bot-ID's, um sicherzustellen, dass die ID automatisch aktualisiert wird, falls sich die Bot-ID in Slack ändert.

locals {
    terraform_bot_id = data.slack_user.terraform_bot.id  # Dynamisch abgerufene ID
}
