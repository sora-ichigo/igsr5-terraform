# Terraform repository for igsr5
![](https://img.shields.io/badge/license-MIT-green)

Infrastructure code at igsr5
## Devlopment Guide 📝
⚠️ 2021/12/31 追記）ひと月で 2万円くらいかかってしまったので、だいぶ構成ケチるようにした。具体的には Nat Gateway を止めて ECS コンテナをパブリックネットワークで管理するようにした。元に戻したい時は https://github.com/igsr5/igsr5-terraform/pull/21 をリバートする。

インフラ構成は https://aws.amazon.com/jp/cdp/ec-container/ とほぼ同じ。
<img src="https://d1.awsstatic.com/icons/jp/cdp/renewal/diagram_ec-container_v2.85a0ad9ebf4bd95e18df84db4b274ba3b36f8586.png" />

## 新しいサービスを動かしたい時

1. `*.igsr5.com` でサブドメインを発行する. 
  特に理由がなければ、 `igsr5.com` にAレコードを追加する方針でいく。
2. 1 で作成したサブドメインに対応する リスナールール、ターゲットグループを `aws_lb.igsr5` に追加する
3. ecs サービスを作成する
4. ecs タスク定義を作成する
5. apply 🎉
