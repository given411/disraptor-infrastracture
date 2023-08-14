
terraform {
      source = "github.com/given411/disraptor-infrastracture//vpc"
}

inputs = {
  env             = "name"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.0.0/19", "10.0.32.0/19"]
  public_subnets  = ["10.0.64.0/19", "10.0.96.0/19"]

  private_subnet_tags = {
      "name" = "tag"
   }

  public_subnet_tags = {
    "name" = "tag"
   }

   
}