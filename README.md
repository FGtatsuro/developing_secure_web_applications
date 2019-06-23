# developing_secure_web_applications

『安全なWebアプリケーションの作り方』試行コード

## 実行環境

- OSX
- Homebrew
- Make

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
