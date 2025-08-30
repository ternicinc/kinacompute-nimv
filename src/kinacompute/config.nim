import options

# ------------------------------
# General App Info
# ------------------------------
const
  app_name*: string = "KinaCompute"
  app_state*: string = "development"
  app_port*: int = 3000

  api_port*: int = 4550
  api_version*: float = 0.1
  api_deployer*: bool = true

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
# Optional Image / Cloud Config
# ------------------------------
type
  ImageConfig* = object
    r2_bucket_name*: Option[string]
    r2_endpoint*: Option[string]
    r2_access_key*: Option[string]
    r2_secret_key*: Option[string]
    images*: seq[string] 

var
  images*: ImageConfig = ImageConfig(
    r2_bucket_name: none(string),
    r2_endpoint: none(string),
    r2_access_key: none(string),
    r2_secret_key: none(string),
    images: @[]  
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

# Helper: Check if Image / R2 storage is configured
proc isImageConfigured*(): bool =
  images.r2_bucket_name.isSome and
  images.r2_endpoint.isSome and
  images.r2_access_key.isSome and
  images.r2_secret_key.isSome

# Helper: Check if there are any actual images defined
proc hasImages*(): bool =
  images.images.len > 0