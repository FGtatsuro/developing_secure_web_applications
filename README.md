# developing_secure_web_applications

『安全なWebアプリケーションの作り方』試行コード

## 実行環境

- OSX
- Homebrew
- Make
- Docker

## 制約

- ホストのDNSサーバに、`127.0.0.1`(dnsmasq)を登録する。
  dnsmasqに上流のDNSは登録されていないため、グローバルな名前解決ができるDNSサーバも登録しなければならない。
- 一部の環境では `mDNSResponder` が53番ポートを使用している場合がある。
  以下のコマンドを実行する事で53番ポートが開放されるが、正しい対処かは分からない。

```
# unload -> load
$ sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist
$ sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist

# 53番ポートを使用していない事の確認
$ sudo lsof -i:53
```

## 脆弱性環境(VM)

```bash
# セットアップ
#   数分間かかる
#   セットアップ後は起動した状態
$ make start OVA_DOWNLOAD_LINK=<ovaファイルのダウンロードリンク(書籍参照)> WASBOOK_PASSWORD=<VMのパスワード(書籍参照)>

# 初回以降の起動
$ make start WASBOOK_PASSWORD=<VMのパスワード(書籍参照)>

# SSH接続
$ make ssh

# 停止
$ make stop
```
