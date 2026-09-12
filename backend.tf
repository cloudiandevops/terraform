terraform {
  backend "s3" {
    bucket         = "demo-terraform-s3-backend-srish"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}
