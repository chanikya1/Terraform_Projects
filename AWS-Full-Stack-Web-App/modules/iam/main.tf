resource "aws_iam_role" "ec2_role" {
  name               = "ec2_role"
  assume_role_policy = data.aws_iam_policy_document.assume_ec2.json
}

data "aws_iam_policy_document" "assume_ec2" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS2ReadOnlyAccess"
}

