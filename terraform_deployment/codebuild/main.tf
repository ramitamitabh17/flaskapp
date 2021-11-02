provider "aws" {
  region  = "us-east-2"
  profile = "default"
}

data "aws_iam_role" "example" {
  name = "codebuild-flaskapp-service-role"
}

resource "aws_codebuild_project" "example" {
  name         = "test-project"
  description  = "test_codebuild_project"
  service_role = data.aws_iam_role.example.arn

  source {
    type            = "GITHUB"
    location        = "https://github.com/ramitamitabh17/flaskapp.git"
    git_clone_depth = 1
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  vpc_config {
    vpc_id = var.vpc_id

    subnets = [
      "${var.subnet1}", "${var.subnet2}"
    ]

    security_group_ids = [
      "${var.sg}"
    ]
  }

  artifacts {
    type           = "S3"
    name           = "flaskappb"
    location       = var.s3_bucket
    namespace_type = "BUILD_ID"
    packaging      = "ZIP"

  }


}
