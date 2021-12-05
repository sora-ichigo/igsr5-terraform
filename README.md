# Terraform repository for igsr5
Infrastructure code at igsr5
## Devlopment Guide 📝

`modules/iam_role` - IAMロールの作成を行うモジュール。

`moduless/security_group` - セキュリティグループの作成を行うモジュール。

`aws_s3.tf` - S3 の管理を行う。

`aws_rds.tf` - RDS の管理を行う。

`aws_vpc.tf` - VPC の管理を行う。

`aws_lb.tf` - Load balancer の管理を行う。

`aws_acm.tf` - ACM の管理を行う。

`aws_route53.tf` - Route53 の管理を行う。

`aws_iam.tf` - IAM の管理を行う。

`aws_ecs.tf` - ECS の管理を行う。

`aws_ecr.tf` - ECR の管理を行う。

`aws_efs.tf` - EFS の管理を行う。

`aws_cloud_watch_logs.tf` - CloudWatch Logs の管理を行う。

`aws_ssm.tf` - SSM の管理を行う。

## 新しいサーバを立てたい時

1. `*.igsr5.com` でサブドメインを発行する. 
  特に理由がなければ、 `igsr5.com` にAレコードを追加する方針でいく。
2. 1 で作成したサブドメインに対応する リスナールール、ターゲットグループを `aws_lb.igsr5` に追加する
3. ecs サービスを作成する
4. ecs タスク定義を作成する
5. apply 🎉
