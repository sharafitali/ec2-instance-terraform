terraform {
  required_version = "1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"  # Replace this with the appropriate version constraint
    }
  }
}

