# channel creation
resource "slack_conversation" "internal" {
  name              = "internal"
  # topic = Thema 
  topic             = "internal meetings and discussions"
  # purpose = Beschreibung
  purpose           = "keep it professional"
  permanent_members = distinct(concat(tolist(slack_usergroup.all.users), [local.terraform_bot_id])) # Hier wird der terraform-Bot standartmäßig hinzugefügt
  is_private        = false
}

resource "slack_conversation" "general" {
  name              = "General"
  topic             = "general"
  purpose           = "Dies ist der eine Channel, der immer alle einbezieht. Es ist ein toller Ort für Mitteilungen und Team-weite Unterhaltungen."
  permanent_members = distinct(concat(tolist(slack_usergroup.all.users), [local.terraform_bot_id]))
  is_private        = false
}

resource "slack_conversation" "vulnerabilities" {
  name              = "vulnerabilities"
  topic             = "various CVE trackers"
  permanent_members = local.permanent_members_it_admins
  is_private        = false
}

resource "slack_conversation" "versity" {
  name              = "versity"
  topic             = "helpful links and topics about certifications and stuff to learn"
  permanent_members = distinct(concat(tolist(slack_usergroup.all.users), [local.terraform_bot_id]))
  is_private        = false
}

resource "slack_conversation" "random" {
  name              = "random"
  topic             = "Allerlei"
  purpose           = "Dieser Channel ist vorgesehen für ... naja, alles andere. Es ist ein Ort für Team-Witze, spontane Ideen und lustige GIFs. Tobe dich aus!"
  permanent_members = distinct(concat(tolist(slack_usergroup.all.users), [local.terraform_bot_id]))
  is_private        = false
}

resource "slack_conversation" "it_admins" {
  name              = "admins"
  topic             = "admins"
  purpose           = "alle admin Themen"
  permanent_members = distinct(concat(
                                tolist(slack_usergroup.it_admins.users), 
                                tolist(slack_usergroup.ceo.users), 
                                tolist(slack_usergroup.technical_management.users),
                                tolist(slack_usergroup.project_management.users), [local.terraform_bot_id]))
  is_private        = false
}

resource "slack_conversation" "_1st-level" {
  name              = "1st-level"
  topic             = "gitlab label notifications 1st-level"
  permanent_members = distinct(concat(
                                tolist(slack_usergroup.technical_team.users),
                                tolist(slack_usergroup.ceo.users), 
                                tolist(slack_usergroup.technical_management.users),
                                tolist(slack_usergroup.project_management.users), [local.terraform_bot_id]))
  is_private        = false
}

resource "slack_conversation" "_2nd-level" {
  name              = "2nd-level"
  topic             = "gitlab label notifications 2nd-level"
  permanent_members = distinct(concat(
                                tolist(slack_usergroup.technical_team.users),
                                tolist(slack_usergroup.ceo.users), 
                                tolist(slack_usergroup.technical_management.users),
                                tolist(slack_usergroup.project_management.users), [local.terraform_bot_id]))
  is_private        = false
}

resource "slack_conversation" "_3rd-level" {
  name              = "3rd-level"
  topic             = "gitlab label notifications 3rd-level"
  permanent_members = distinct(concat(
                                tolist(slack_usergroup.it_admins.users),
                                tolist(slack_usergroup.ceo.users), 
                                tolist(slack_usergroup.technical_management.users),
                                tolist(slack_usergroup.project_management.users), [local.terraform_bot_id]))
  is_private        = false
}

resource "slack_conversation" "support-team" {
  name              = "support"
  topic             = "for support team meetings"
  permanent_members = distinct(concat(
                                tolist(slack_usergroup.technical_team.users),
                                tolist(slack_usergroup.ceo.users), 
                                tolist(slack_usergroup.technical_management.users),
                                tolist(slack_usergroup.project_management.users), [local.terraform_bot_id]))
  is_private        = false
}

resource "slack_conversation" "monitoring" {
  name              = "monitoring"
  topic             = "monitoring notifications and alerts"
  permanent_members = distinct(concat(
                                tolist(slack_usergroup.it_admins.users),
                                tolist(slack_usergroup.ceo.users), 
                                tolist(slack_usergroup.technical_management.users),
                                tolist(slack_usergroup.project_management.users),
                                tolist(slack_usergroup.azubi.users),
                                tolist(slack_usergroup.working_student.users), [local.terraform_bot_id]))
  is_private        = false
}

resource "slack_conversation" "helpdesk" {
  name              = "helpdesk"
  topic             = "zammad notifications"
  permanent_members = distinct(concat(
                                tolist(slack_usergroup.technical_team.users),
                                tolist(slack_usergroup.ceo.users), 
                                tolist(slack_usergroup.technical_management.users),
                                tolist(slack_usergroup.project_management.users), [local.terraform_bot_id]))
  is_private        = false
}

resource "slack_conversation" "project-team" {
  name              = "project"
  topic             = "for project team meetings"
  permanent_members = distinct(concat(
                                tolist(slack_usergroup.senior.users),
                                tolist(slack_usergroup.ceo.users), 
                                tolist(slack_usergroup.technical_management.users),
                                tolist(slack_usergroup.project_management.users), [local.terraform_bot_id]))
  is_private        = false
}

resource "slack_conversation" "development" {
  name              = "development"
  topic             = "Development topics"
  permanent_members = distinct(concat(
                                tolist(slack_usergroup.senior.users),
                                tolist(slack_usergroup.ceo.users), 
                                tolist(slack_usergroup.technical_management.users),
                                tolist(slack_usergroup.project_management.users), [local.terraform_bot_id]))
  is_private        = false
}

resource "slack_conversation" "gitlab" {
  name              = "gitlab"
  topic             = "gitlab general notifications"
  permanent_members = distinct(concat(
                                tolist(slack_usergroup.technical_team.users),
                                tolist(slack_usergroup.ceo.users), 
                                tolist(slack_usergroup.technical_management.users),
                                tolist(slack_usergroup.project_management.users), [local.terraform_bot_id]))
  is_private        = false
}

resource "slack_conversation" "management_board" {
  name              = "management_board"
  topic             = "management_board"
  permanent_members = distinct(concat(tolist(slack_usergroup.management_board.users), [local.terraform_bot_id]))
  is_private        = false
}

resource "slack_conversation" "marketing" {
  name              = "marketing"
  topic             = "marketing discussions"
  permanent_members = distinct(concat(tolist(slack_usergroup.marketing_team.users), [local.terraform_bot_id]))
  is_private        = false
}

resource "slack_conversation" "buchhaltung" {
  name              = "buchhaltung"
  topic             = "Buchhaltungs Themen"
  permanent_members = distinct(concat(tolist(slack_usergroup.buchhaltung.users), [local.terraform_bot_id]))
  is_private        = false
}


resource "slack_conversation" "onboarding" {
  name              = "onboarding"
  topic             = "Sämtliche links für Neue Mitarbeiter"
  permanent_members = distinct(concat(
                                tolist(slack_usergroup.hr.users),
                                tolist(slack_usergroup.junior.users), 
                                tolist(slack_usergroup.technical_management.users),
                                tolist(slack_usergroup.azubi.users),
                                tolist(slack_usergroup.project_management.users), [local.terraform_bot_id]))
  is_private        = false
}

resource "slack_conversation" "ausbildung" {
  name              = "ausbildung"
  topic             = "Alles Azubi-Ausbildung's Themen"
  purpose           = "Firmeninterner Klassenzimmer Kanal"
  permanent_members = distinct(concat(
                                tolist(slack_usergroup.ausbilder.users),
                                tolist(slack_usergroup.azubi.users), [local.terraform_bot_id]))
  is_private        = false
}

# noch abklären
resource "slack_conversation" "sipgate" {
  name              = "sipgate"
  topic             = "Info zu Rückrufe"
  permanent_members = distinct(concat(tolist(slack_usergroup.sipgate.users), [local.terraform_bot_id]))
  is_private        = true
}

resource "slack_conversation" "azubis" {
  name              = "Azubis"
  topic             = "Infoaustusch nur unter Azubis"
  permanent_members = distinct(concat(tolist(slack_usergroup.azubi.users), [local.terraform_bot_id]))
  is_private        = true
}


################################################################################

# customer channels
resource "slack_conversation" "kunde1" {
  name              = "kunde1"
  topic             = "kunde1"
  permanent_members = distinct(concat(tolist(slack_usergroup.kunde1.users), [local.terraform_bot_id]))
  is_private        = false
}

resource "slack_conversation" "kunde2" {
  name              = "kunde2"
  topic             = "kunde2"
  permanent_members = distinct(concat(tolist(slack_usergroup.kunde2.users), [local.terraform_bot_id]))
  is_private        = false
}
