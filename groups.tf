# Diese Datei definiert die Slack Usergroups für die Channel zuordnung.
# Jede Usergroup hat eine Liste von Mitgliedern, die in der entsprechenden
# lokalen Variable `local.permanent_members_<group>` definiert ist.

resource "slack_usergroup" "all" {
  name        = "All"
  handle      = "all"
  description = "Alle Mitarbeiter"
  users       = local.permanent_members_all
}

resource "slack_usergroup" "ceo" {
  name        = "Ceo"
  handle      = "ceo"
  description = "Ceo"
  users       = local.permanent_members_ceo
}

resource "slack_usergroup" "executive_management" {
  name        = "Executive-Management"
  handle      = "executive_management"
  description = "Geschäftsführung"
  users       = local.permanent_members_executive_management
}

resource "slack_usergroup" "management_board" {
  name        = "Management-Board"
  handle      = "management_board"
  description = "Geschäftsführung mit Marketing-team"
  users       = local.permanent_members_management_board
}

resource "slack_usergroup" "project_management" {
  name        = "Project-Management"
  handle      = "project_management"
  description = "Project-Management"
  users       = local.permanent_members_project_management
}

resource "slack_usergroup" "technical_management" {
  name        = "Technical-Management"
  handle      = "technical_management"
  description = "Technical-Management"
  users       = local.permanent_members_technical_management
}

resource "slack_usergroup" "it_admins" {
  name        = "IT-Admins"
  handle      = "it_admins"
  description = "Nur Admins"
  users       = local.permanent_members_it_admins
}

resource "slack_usergroup" "technical_team" {
  name        = "Technical-Team"
  handle      = "technical_team"
  description = "Alle Techniker inkls Azubi's und Werkstudenten"
  users       = local.permanent_members_technical_team
}

resource "slack_usergroup" "senior" {
  name        = "Senior"
  handle      = "senior"
  description = "Senior-Team"
  users       = local.permanent_members_senior
}

resource "slack_usergroup" "junior" {
  name        = "Junior"
  handle      = "junior"
  description = "Junior-Team"
  users       = local.permanent_members_junior
}

resource "slack_usergroup" "working_student" {
  name        = "Working-Student"
  handle      = "working_student"
  description = "Werkstudent"
  users       = local.permanent_members_working_student
}

resource "slack_usergroup" "azubi" {
  name        = "Azubi"
  handle      = "azubi"
  description = "Auszubildende"
  users       = local.permanent_members_azubi
}

resource "slack_usergroup" "ausbilder" {
  name        = "Ausbilder"
  handle      = "ausbilder"
  description = "zuständige für Azubis"
  users       = local.permanent_members_ausbilder
}

resource "slack_usergroup" "project_team" {
  name        = "Project-Team"
  handle      = "project_team"
  description = "Projekt Gruppe-Team"
  users       = local.permanent_members_project_team
}

resource "slack_usergroup" "developers" {
  name        = "Entwickler"
  handle      = "dev_team"
  description = "Entwicklungs-team"
  users       = local.permanent_members_developers
}

resource "slack_usergroup" "administration_team" {
  name        = "Administration-Team"
  handle      = "administration_team"
  description = "Büro Verwaltungs-Team"
  users       = local.permanent_members_administration_team
}

resource "slack_usergroup" "hr" {
  name        = "HR"
  handle      = "hr"
  description = "Personalabteilungs-Team"
  users       = local.permanent_members_hr
}

resource "slack_usergroup" "buchhaltung" {
   name        = "Buchhaltung"
   handle      = "buchhaltung"
   description = "Buchhaltungs-Team"
   users       = local.permanent_members_buchhaltung
 }

resource "slack_usergroup" "sipgate" {
  name        = "Sipgate"
  handle      = "sipgate"
  description = "Sipgate Anruferinfos"
  users       = local.permanent_members_sipgate
}

resource "slack_usergroup" "marketing_team" {
  name        = "Marketing-Team"
  handle      = "marketing_team"
  description = "Marketing-Team"
  users       = local.permanent_members_marketing_team
}

resource "slack_usergroup" "externe" {
  name        = "Externe"
  handle      = "externe"
  description = "externe für marketing"
  users       = local.permanent_members_externe
}

# customer groups

resource "slack_usergroup" "kunde1" {
  name        = "kunde1"
  handle      = "kunde1"
  description = "kunde1"
  users       = local.permanent_members_kunde1
}

resource "slack_usergroup" "kunde2" {
  name        = "kunde2"
  handle      = "kunde2"
  description = "kunde2"
  users       = local.permanent_members_kunde2
}

