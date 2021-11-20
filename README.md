# Terraform repository for igsr5

## Guide

### module
#### iam_role
IAMロールの作成を行う。入力パラメータとして
- name: IAM ロールと IAM ポリシーの名前
- policy: ポリシードキュメンｔ
- identifier: IAM ロールを関連づける AWS のサービス識別子

を持っている。
