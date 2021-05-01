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

Gitをインストールできたら、次のコマンドを実行してこのレポジトリをcloneします。 `--recursive` を忘れないでください。submoduleをcloneするために必要です。

```
git clone --recursive https://github.com/smalruby/smalruby3-develop.git
```

もし `--recursive` をつけ忘れたら `git submodule update --init --recursive` を実行すると submodule を clone できます。

## 開発環境の構築

### Dockerイメージの構築

```
$ docker-compose build
$ docker-compose run smalruby3-gui bash -c 'cd /app/scratch-vm && npm install && npm run build && npm link'
$ docker-compose run smalruby3-gui bash -c 'cd /app/smalruby3-gui && npm install && npm link scratch-vm'
```

### smalruby3-guiの起動

```
$ docker-compose up
(省略)
smalruby3-gui_1  | ℹ ｢wdm｣: Compiled successfully.
```

しばらく待ち、↑のように `smalruby3-gui_1  | ℹ ｢wdm｣: Compiled successfully.` と表示されたら OK です。

ウェブブラウザで http://127.0.0.1:8601 を開けばスモウルビー3を操作できます。

これだけで開発環境が整います。

### smalruby3-guiの停止

```
$ docker-compose stop
```

## 開発方法

smalruby3-gui/README.md と scratch-vm/README.md をご覧ください。
