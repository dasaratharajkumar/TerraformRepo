resource "aws_dynamodb_table" "hackathon_table" {
  name         = "hackathon-table-squad1"
  billing_mode = "PROVISIONED"
  attribute {
    name = "id"
    type = "S"
  }

  hash_key = "id"

  tags = {
    Name        = "hackathon-table-squad1"
    Team        = "Squad1"
  }
}