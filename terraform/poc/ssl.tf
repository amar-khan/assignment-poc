resource "tls_private_key" "tls_priv_key" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "tls_priv_cert" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.tls_priv_key.private_key_pem

  subject {
    common_name  = "${var.environment}.${var.service}.com"
    organization = "${var.service} ${var.environment} GmbH"
  }

  validity_period_hours = 240

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "cert" {
  private_key      = tls_private_key.tls_priv_key.private_key_pem
  certificate_body = tls_self_signed_cert.tls_priv_cert.cert_pem
}