terraform {
  backend "s3" {
    bucket = "tfdemo-aman"
    key = "backend.tfstate" #Jab hmm main.tf run karenge tab s3 me .tfstate name ka file ban jayega aur data store hoga. Backend hamara yaha pe s3 bucket hai. Iske andar tfstate file banega aur data store rahega.
    region = "ap-south-1"
    dynamodb_table = "tfstate_gondan"
  }
}