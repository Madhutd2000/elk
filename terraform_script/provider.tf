provider "aws" {      # Defining the Provider Amazon  as we need to run this on AWS   
  region = var.region 
  access_key = var.access_key
  secret_key = var.secret_key
  token = var.aws_session_token
 
}
