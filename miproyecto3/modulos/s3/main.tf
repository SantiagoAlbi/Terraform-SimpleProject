resource "aws_s3_bucket" "cerberus_bucket" {
  bucket = var.bucket_name
}

module "terraform_state_backend" {
     source = "cloudposse/tfstate-backend/aws"
     # Cloud Posse recommends pinning every module to a specific version
     version     = "1.4.1"
     namespace  = "eg"
     stage      = "test"
     name       = "terraform"
     attributes = ["state"]

     terraform_backend_config_file_path = "."
     terraform_backend_config_file_name = "backend.tf"
     force_destroy                      = false
   }