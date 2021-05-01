## スモウルビー3用の開発環境

smalruby3-develop は、スモウルビー3をすぐに開発できるようにするためのDockerの設定ファイルや各種レポジトリを集めたものです。Dockerとgitをインストールするだけで、好きなエディターでスモウルビー3を開発できるようになります。

## 準備

### Dockerのインストール

お使いのOSに合わせて、以下のソフトウェアをインストールしてください。

 - Windows: https://www.docker.com/docker-windows
 - Mac: https://www.docker.com/docker-mac

### Gitのインストールとソースコードのclone

お使いのOSに合わせて、Gitをインストールしてください。

 - Windows: https://gitforwindows.org/
 - Mac: ターミナルアプリを起動して、`xcode-select --install` コマンドを実行後、画面の指示に従ってインストールしてください。

Gitをインストールできたら、次のコマンドを実行してこのレポジトリをcloneします。

```
git clone https://github.com/smalruby/smalruby3-develop.git
```

## 開発環境の構築

### Dockerイメージの構築

```
$ docker-compose build
```

### smalruby3-guiの起動

```
$ docker-compose up -d
```

ウェブブラウザで http://127.0.0.1:8601 を開けばスモウルビー3を操作できます。

これだけで開発環境が整います。

### smalruby3-guiの停止

```
$ docker-compose stop
```

## 開発方法

smalruby3-gui/README.md と scratch-vm/README.md をご覧ください。
