module "s3-bucket" {
  source                    = "terraform-aws-modules/s3-bucket/aws"
  version                   = "3.15.1"

  bucket                    = "learn-lambda-my-bucket"

  force_destroy             = true
  control_object_ownership  = true
  object_ownership          = "ObjectWriter"

  versioning = {
    enabled = false
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket      = module.s3-bucket.s3_bucket_id
  eventbridge = true
}
