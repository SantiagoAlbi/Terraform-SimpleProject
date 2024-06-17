terraform {
  required_version = "~>1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.1"
    }


  }

  # backend "s3" {
  #    region         = "us-east-1"
  #    bucket         = "< the name of the S3 state bucket >"
  #    key            = "terraform.tfstate"
  #    dynamodb_table = "< the name of the DynamoDB locking table >"
  #    profile        = ""
  #    role_arn       = ""
  #    encrypt        = true
  #  }


}


 module "tfstate-backend" {
    source  = "./modulos/s3"
#    version = "1.4.1"
    
 } 

module "mybucket" {
  source      = "./modulos/s3"
  bucket_name = "practicaterraviejajonny"
}


# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = var.tags
  }
}