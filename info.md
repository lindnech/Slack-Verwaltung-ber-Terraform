# Slack Channels und Benutzerverwaltung mit Terraform

[excel-liste](SlackumbauGruppenInfo.xlsx)

---
## Aufgaben: einfacherer Terraform Verwaltung:

|Nr.:|Frage:|Antwort:|
|:---:|:--------|:-------------|
|1.  |**Was brauchen wir?**|[eine einfachere Verwaltung](#info-umbau-slack-terraform)|
|2.  |**Wo neue user anlegen?**|[am besten in einer Zeile](#neue-user-anlegen)|
|3.  |**Welche Gruppen brauchen wir?**|[siehe Gruppenliste](#gruppenliste)|
|4.  |**Wie user zu Gruppen hinzufügen?**|[durch Rollen in der Userliste](#user-zu-usergruppen-hinzufügen)|
|5.  |**Welche Gruppe zu welchen Channel?**|[siehe Channelliste](#channelliste-mit-gruppenzuordnung)|
|6.  |**Wie Gruppen zu Channels hinzufügen ohne Doppel vorkommen?**|[distinct](#channels-doppelungen-vermeiden-bei-mehreren-usergroups-in-einen-channel)|
|7.  |**Wie bauen wir externe ein?**|[Monika Sedivy](#wie-externe-einbauen)|
|8.  |**Bots bzw terraform bot im code integrieren**|[Bots](#bots) |
|9.  |**api abfragen**|[API abschnitt](#api-abfragen)|

---
## Wie funktionierte die alte (noch aktuelle) Version:

### main.tf

```
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
```

es handelt sich um eine Terraform-Konfiguartationsdatei die den Grundstein für die Verwaltung des Slack-Arbeitsbereiches legt.   

1.  Terraform-Backend:

    - Ein http Backend wird konfiguriert.

2.  Anforderungen:

    - Der Terraform-Provider für Slack wird verwendet, um Slack-Ressourcen zu verwalten.    
    - Es wird der Provider slack von Figma verwendet, mit der Version 1.3.2.   

3.  Slack Provider:

    - Es wird ein Slack-Provider konfiguriert.

4. Benutzung:

    - **Vor der Ausführung von `terraform apply`  muss das `SLACK_TOKEN` in der Umgebung gesetzt sein, um Zugriff auf den Slack-Arbeitsbereich zu haben.**   

### slack token permanent verwenden

mit folgenden befehl hinterlegst du den slack token permanent und musst ihn nicht ständig bei jeden apply angeben:

<div align="center">

`export SLACK_TOKEN="dein-slack-token-hier"`

</div>

Ersetze `"dein-slack-token-hier"` durch den tatsächlichen Slack-Token.

---

### members.tf

Die `members.tf` Datei in Terraform `wurde/wird` verwendet, um Benutzer in einem Slack-Arbeitsbereich zu verwalten und ihnen Rollen oder Gruppen zuzuweisen. 

1.  Lokale Variablen (locals):

    - Es gibt für jeden channel eine Listen von Benutzernamen (z.B. all, hr, management_board, usw).
    - Diese Listen enthalten die Benutzernamen von Personen (ohne die vollständigen E-Mail-Adressen).

```
# list of user names
locals {
  all = [
    "user.1",
    "user.2",
    "user.3",
    "user.4",
    "user.5",
    "user.6",
    "user.7",
    "user.8",
    "user.9",
    "user.10",
    "user.11",
    "user.12",
    "user.13",
  ]

  hr = [
    "user.1",
    "user.2",
  ]
management_board = [
    "user.1",
    "user.2",
    "user.10",
  ]
}
```

2.  Benutzer-Daten (iD's) abrufen:

    - data "slack_user" wird verwendet, um die Slack-IDs der Benutzer basierend auf den E-Mail-Adressen abzurufen. Die E-Mail-Adressen werden automatisch generiert, indem die Benutzernamen aus den lokalen Listen mit der Domäne kombiniert werden (z.B. "user.1@domain.com").
    - Es werden sämtliche Gruppen von Benutzern geladen wie im beispiel "all": 
```
data "slack_user" "all" {
  for_each = toset(local.all)
  email    = "${each.key}@domain.com"
}
```

|**INFO:**|
|---------|
|`toset()` konvertiert die Liste um Duplikate zu verhindern.
`email    = "${each.key}@domain.com"` Für jedes Element der Liste wird eine E-Mail-Adresse erstellt. Dabei wird der Name (beispiel "user.1") aus der Liste entnommen und an die Domain `@domain.com` angehängt.   
Das Ergebnis wird dann genutzt, um die entsprechenden Slack-Benutzer über ihre E-mail-Adresse zu identifizieren.|

---
---


3.  Verwendung und ablegen der Benutzer-IDs in Array's,
:

    - Die IDs der Benutzer werden in verschiedenen Variablen (Arrays) gespeichert (z.B. permanent_members_all, permanent_members_management_board).
    - Diese Listen von Benutzer-IDs können dann verwendet werden, um die Mitglieder von Slack-Kanälen zu verwalten oder andere Terraform-Ressourcen zu erstellen.

```
# use for channel creation
locals {
  permanent_members_all              = [for u in data.slack_user.all : u.id]
  permanent_members_management_board = [for u in data.slack_user.management_board : u.id]
  permanent_members_marketing        = [for u in data.slack_user.marketing : u.id]
  }
```

---

### conversations.tf

Beispiel Inhalt:
```
resource "slack_conversation" "management_board" {
  name              = "management_board"
  topic             = "marketing discussions"
  permanent_members = local.permanent_members_management_board
  is_private        = false
}
```   
   

Die `conversation.tf` Datei in Terraform wird verwendet, um Slack-Kanäle (conversations) mit bestimmten Namen und Themen zu erstellen und ihre Mitglieder zu verwalten.

1.  resource "slack_conversation":

    - Diese Ressource erstellt einen Slack-Kanal mit den angegebenen Eigenschaften.

2.  Beispiele für die Konfiguration:

    - Im Beispiel wird ein Kanal mit dem    
    *Namen* `management_board` erstellt, der das    
    *Thema(topic)* `marketing discussions` hat.    
    Die Mitglieder dieses Kanals sind eine kombinierte Liste von Benutzern die in der `members.tf` definiert sind. `local.permanent_members_management_board` 
    - Der Kanal ist nicht privat (is_private = false).

---
---
---

## Info umbau Slack-Terraform

Ziel vom Umbau ist es eine einfachere Verwaltung zu haben.   

Somit ist der Plan:
  - [x] allgemein einmal die `Channels` zu erstellen (`conversation.tf`)
  - [x] und einmalig die `usergroups` zu erstellen (`groups.tf`)
  - [x] und einmalig die gruppen den channels zu zuweisung. (`conversation.tf`)

  - [X] aus vielen Listen in der `members.tf` (pro channel eine Liste)   
    wird eine `zentrale userliste mit definierte roles` erstellt (siehe `users.tf`).   
  - [x] Neue users.tf anpassen im bereich internen emails
  - [ ] terraform bot in terraform code integrieren für automatische channel integration
  - [ ] testen 
  - [ ] überprüfen und falls nötig Channels und Groups anpassen


## Umbau auf einfachere Verwaltung

### Zentrale Verwaltung 

  Eine Benutzerliste, die leicht zu verwalten ist. Neue Benutzer können einfach hinzugefügt werden und sie werden automatisch den channels hinzugefügt ohne mehrere Listen bearbeiten zu müssen, dies geschieht durch die Rollen vergabe.

### Automatische Gruppenzuweisung

  Durch die Rollen werden Benutzer automatisch den entsprechenden Slack-Gruppen zugeordnet.
  Es wird dynamisch auf Basis der zentralen Benutzerliste erstelltt.

### Automatische Gruppenzuordnung in den Channels

  In der conversation.tf werden die gruppen einmalig den channels zugeordnet, somit werden neue user anhand der definierten Rolen in die Gruppen gepackt und die channels holen sich automatisch die Gruppen.

---
---
### neue user Anlegen

* Neue **user** müssen somit nur in einer Zeile hinzugefügt werden mit:
  1.  name
  2.  email
  3.  roles (rolle zur automatischen Gruppenzuweisung)

  **Beispiel:**

  `"max.musterman"   = { email = "max.musterman@domain.com", roles = ["all", "it_admins","technical_team", "junior", "sipgate"] }, `

---
---

### user zu usergruppen hinzufügen

**Neue user** werden den usergroups **automatisch hinzugefügt**, anhand von Rollen (roles) wie in der `users.tf` ersichtilch.

**Beispiel:**

```
locals {
  users = {
    "max.musterman" = { email = "max.musterman@domain.com", roles = ["all", "it_admins", "(weitere Gruppen)" ] },
  }
}

```
---
---

### Channelliste mit Gruppenzuordnung

|**Anzahl**|**channels**   |**groups**  |
|:----------:|:---------------:|:----------|
|1|internal       |all       |
|2|general        |all       |
|3|versity        |all       |
|4|vulnerabilities|admins, ceo, projekt- u. technical-management | 
|5|random         |all|
|6|admins         |admins, ceo, projekt- u. technical- management|
|7|1st-level      |technical-team, ceo, projekt- u. technical- management|
|8|2nd-level      |technical-team, ceo, projekt- u. technical- management|
|9|3rd-level      |admins, ceo, projekt- u. technical- management|
|10|support        |technical-team, ceo, projekt- u. technical- management|
|11|monitoring     |admins, ceo, projekt- u. technical- management|
|12|helpdesk       |technical-team, ceo, projekt- u. technical- management|
|13|project        |senior, ceo, projekt- u. technical- management|
|14|development    |senior, ceo, projekt- u. technical- management|
|15|gitlab         |technical-team, ceo, projekt- u. technical- management|
|16|management_board|management-board,|
|17|marketing      |marketing-team|
|18|buchhaltung    |buchhaltung|
|19|onboarding     |hr, projekt- u. technical- management, juniors, werkstudent, azubi|
|20|ausbildung     |Ausbilder, azubi|
|21|sipgate        |sipgate|
|22|azubis         |azubi|
|23|kunde1         |kunde1|
|24|kunde2            |kunde2|

### Channels: Doppelungen vermeiden bei mehreren usergroups in einen channel

**Wie Gruppen zu Channels hinzufügen ohne Doppel vorkommen?**

```
resource "slack_conversation" "admins" {
  name              = "admins"
  topic             = "devs get paid to write code. we get paid to think"
  permanent_members = distinct(concat(
                               tolist(slack_usergroup.it_admins.users), 
                               tolist(slack_usergroup.project_team.ceo), 
                               tolist(slack_usergroup.project_management.users)))
  is_private        = false
}
```
Die Lösung liegt in folgenden funktionen, die wir bei `permanent_members =`anwenden:

1.  **tolist:**  ein festgelegter Wert der durch tolist in eine unsortierte Liste umgewandelt wird.
2.  **concat** concat nimmt 2 oder mehrere Listen und kombiniert sie zu einer Liste (Doppelungen möglich)
3.  **distinct** nimmt eine Liste und gibt eine neue Liste zurück, aus der alle doppelten Elemente entfernt wurde. Somit bleiben die ersten Vorkommen jedes Wertes erhalten.

---
---

### Gruppenliste

**welche usergruppen haben wir?**

|**Anzahl**|**Gruppen:**|
|:-------:|------|
|1|all|
|2|ceo|
|3|executive_management|
|4|management_board|
|5|project_management|
|6|technical_management|
|7|it_admins|
|8|technical_team|
|9|senior|
|10|junior|
|11|working_student|
|12|azubi|
|13|ausbilder|
|14|project_team|
|14a|developers|
|15|administration_team|
|16|hr|
|17|buchhaltung|
|18|sipgate|
|19|marketing_team|
|20|externe|
|--- |---|
|--- |**Firmengruppen:**|
|21|kunde1|
|22|kunde2|

---

### Users:

#### wie externe einbauen?

**indem ich die `users.tf` folgend anpasse:**

users werden so angelegt:
`"user.x" = { email = "hallo@user.x.de", roles = ["externe", "marketing-team"] },`

und so werden alle users verwendet egal welche email sie haben, da diese ja mit definiert werden:

```
data "slack_user" "users" {
  for_each = toset(local.users)
  email    = each.value.email
}
```
### Api abfragen:

  1. Wie sehe ich alle user in Slack?
     im Terminal folgenden befehl eingeben aber den slack token vorher einfügen.

  `curl -X GET "https://slack.com/api/users.list"  -H "Authorization: Bearer <xoxb-slack-token>"| jq '.members[] | {id: .id, name: .name}'` 

#### Info api abfrage
  im oberen command (curl -X GET....) wird eine user.list abgefragt um die ausgabe zu sortieren wird `jq` verwendet um die JSON-Ausgabe zu filtern.

  - Installiere `jq`falls nicht vorhanden:
    * Ubuntu: `sudo apt-get install jq`
    * macOS:  `brew install jq`

- im command oben wird nun `jq '.members[] | {id: .id, name: .name}'` verwendet um nur ID's und Namen der Benutzer anzeigen zu lassen.

### Bots

Wie können wir vorhandene Bots wie den `Terraform bot` automatisch jeden channel hinzufügen?

mein ansatz war in der `conversations.tf` unter resource "slack_conversation" "<channelname>"
zu definieren.

beispiel:

`managed_by = [local.terraform_bot_id]`

jedoch geht das scheinbar nicht, da es in der aktuellen Version des Slack Terraform Providers es keine direkte managed_by-Eigenschaft gibt.

also kann ich ihn als `permanent_members`hinzufügen

beispiel:

`permanent_members = distinct(concat(tolist(slack_usergroup.all.users), [local.terraform_bot_id]))`



