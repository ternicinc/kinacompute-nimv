# src/kinacompute/config.nim

import options

# ------------------------------
# General App Info
# ------------------------------
const
  app_name*: string = "KinaCompute"
  app_state*: string = "development"

# ------------------------------
# Mandatory Configuration
# ------------------------------
type
  DatabaseConfig* = object
    url*: string

  MasterNodeConfig* = object
    ip*: string
    ssh_public_keys*: string

var
  database*: DatabaseConfig = DatabaseConfig(url: "set_me")
  master_node*: MasterNodeConfig = MasterNodeConfig(
    ip: "set_me",
    ssh_public_keys: "set_me"
  )

# ------------------------------
# Optional Services
# ------------------------------
type
  HeartbeatConfig* = object
    url*: Option[string]

  AuthConfig* = object
    github_id*: Option[string]
    github_secret*: Option[string]
    google_id*: Option[string]
    google_secret*: Option[string]

  SMTPConfig* = object
    user*: Option[string]
    password*: Option[string]
    hostname*: Option[string]
    port*: Option[string]
    tls*: bool

var
  # Example to set heartbeat URL: heartbeat.url = some("https://heartbeat.example.com/ping")
  # More examples soon. TM.
  heartbeat*: HeartbeatConfig = HeartbeatConfig(url: none(string))
  auth*: AuthConfig = AuthConfig(
    github_id: none(string),
    github_secret: none(string),
    google_id: none(string),
    google_secret: none(string)
  )
  smtp*: SMTPConfig = SMTPConfig(
    user: none(string),
    password: none(string),
    hostname: none(string),
    port: none(string),
    tls: true
  )

# ------------------------------
# Helper Functions
# ------------------------------

# Helper: check if database is configured
proc isDatabaseConfigured*(): bool =
  return database.url != "set_me"

# Helper: check if SMTP is fully configured
proc isSMTPConfigured*(): bool =
  smtp.user.isSome and smtp.password.isSome and smtp.hostname.isSome and smtp.port.isSome

# Helper: check if GitHub auth is configured
proc isGithubAuthConfigured*(): bool =
  auth.github_id.isSome and auth.github_secret.isSome
