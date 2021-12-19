# Terraform repository for igsr5
Infrastructure code at igsr5
## Devlopment Guide 📝

:wip

## 新しいサーバを立てたい時

1. `*.igsr5.com` でサブドメインを発行する. 
  特に理由がなければ、 `igsr5.com` にAレコードを追加する方針でいく。
2. 1 で作成したサブドメインに対応する リスナールール、ターゲットグループを `aws_lb.igsr5` に追加する
3. ecs サービスを作成する
4. ecs タスク定義を作成する
5. apply 🎉
