terraform {
  backend "s3" {
    bucket         = "hackathon-bucket-squad1"
    key            = "statefile"
    region         = "us-east-1"
    dynamodb_table = "hackathon-table-squad1"
  }
}