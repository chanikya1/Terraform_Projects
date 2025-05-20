variable "bucket_name" {
  description = "Unique name for the S3 bucket"
  type        = string
}

variable "enable_versioning" {
  description = "Enable versioning on the bucket"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to assign to the bucket"
  type        = map(string)
  default     = {}
}

