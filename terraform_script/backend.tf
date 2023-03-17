terraform {
  backend "s3" {

    #bucket         = "eks-tfstate-storage-testing"
    #dynamodb_table = "eks-tfstate-locks"

    encrypt        = true
  }
}
