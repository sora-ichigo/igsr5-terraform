// resource "aws_cloudfront_distribution" "igsr5" {
//   origin {
//     domain_name = "igsr5.com"
//     origin_id   = "ELB-igsr5"
// 
//     custom_origin_config {
//       http_port              = 80
//       https_port             = 443
//       origin_protocol_policy = "https-only"
//       origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
//     }
//   }
// 
//   enabled = true
// 
//   default_cache_behavior {
//     allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
//     cached_methods         = ["GET", "HEAD"]
//     target_origin_id       = "ELB-igsr5"
//     viewer_protocol_policy = "allow-all" # HTTP and HTTPS
//     min_ttl                = 0
//     default_ttl            = 86400
//     max_ttl                = 31536000
// 
//    forwarded_values {
//       query_string = true
// 
//       cookies {
//         forward = "none"
//       }
//     }
//   }
// 
//   restrictions {
//     geo_restriction {
//       restriction_type = "none"
//     }
//   }
// 
//   viewer_certificate {
//     acm_certificate_arn      = "arn:aws:acm:us-east-1:799705073177:certificate/72fa95c7-b18f-477e-b15b-e7e6fa1658de"
//     ssl_support_method       = "sni-only"
//     minimum_protocol_version = "TLSv1"
//   }
// }
