terraform {
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "us-east-1"
}

module "rds" {
  source = "../../modules/rds"

  db_name              = "fiapdb_dev"
  db_username          = "postgresadmin"
  db_password          = var.db_password
  db_instance_class    = "db.t3.micro"
  db_allocated_storage = 20
  db_engine_version    = "17.4"

  subnet_ids = var.subnet_ids
  vpc_id     = var.vpc_id
}

