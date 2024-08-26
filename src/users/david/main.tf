variable "message" {
  type = string
}

output "greeting" {
  value = var.message
}