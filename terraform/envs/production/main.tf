module "apps_env" {
  source           = "../../modules/apps_env_baseline"
  project          = var.apps_project
  region           = var.apps_region
  database_tier    = var.database_tier
  bucket           = var.apps_terraform_state_bucket
  bucket_location  = var.bucket_location
  platform_project = var.project
  domain           = var.apps_domain
}

module "env" {
  source                           = "../../modules/env_baseline"
  project                          = var.project
  region                           = var.region
  app_engine_region                = ""
  github_client_id                 = var.github_client_id
  github_scope                     = var.github_scope
  github_redirect_uri              = var.github_redirect_uri
  github_app_auth_scope            = var.github_app_auth_scope
  github_app_auth_redirect_uri     = var.github_app_auth_redirect_uri
  amplitude_api_key                = var.amplitude_api_key
  paddle_vendor_id                 = var.paddle_vendor_id
  sendgrid_from_address            = var.sendgrid_from_address
  sendgrid_invitation_template_id  = var.sendgrid_invitation_template_id
  paddle_base_64_public_key        = var.paddle_base_64_public_key
  database_tier                    = var.database_tier
  image_id                         = var.image_id
  bcrypt_salt_or_rounds            = var.bcrypt_salt_or_rounds
  github_client_secret_id          = var.github_client_secret_id
  segment_write_key_secret_id      = var.segment_write_key_secret_id
  sendgrid_api_key_secret_id       = var.sendgrid_api_key_secret_id
  github_app_private_key           = var.github_app_private_key
  github_app_client_secret         = var.github_app_client_secret
  github_app_client_id             = var.github_app_client_id
  github_app_app_id                = var.github_app_app_id
  github_app_installation_url      = var.github_app_installation_url
  feature_flags                    = var.feature_flags
  default_disk                     = var.default_disk
  host                             = var.host
  server_database_connection_limit = var.server_database_connection_limit
  server_min_scale                 = var.server_min_scale
  server_max_scale                 = var.server_max_scale
  bucket                           = var.bucket
  bucket_location                  = var.bucket_location
  apps_project                     = var.apps_project
  container_builder_default        = var.container_builder_default
  deployer_default                 = var.deployer_default
  apps_region                      = var.apps_region
  apps_terraform_state_bucket      = var.apps_terraform_state_bucket
  apps_domain                      = var.apps_domain
  apps_dns_zone                    = module.apps_env.zone
  apps_database_instance           = module.apps_env.database_instance
}

module "deploy" {
  source                             = "../../modules/manual_deploy"
  project                            = var.project
  region                             = var.region
  database_name                      = module.env.database_name
  database_instance                  = module.env.database_instance
  github_client_secret_id            = var.github_client_secret_id
  segment_write_key_secret_id        = var.segment_write_key_secret_id
  sendgrid_api_key_secret_id         = var.sendgrid_api_key_secret_id
  image                              = var.image
  google_cloudbuild_trigger_filename = var.google_cloudbuild_trigger_filename
  google_cloudbuild_trigger_name     = var.google_cloudbuild_trigger_name
  github_owner                       = var.github_owner
  github_name                        = var.github_name
  github_tag                         = var.github_tag
}
