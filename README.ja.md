# スモウルビー用の開発環境

smalruby3-develop は、スモウルビーをすぐに開発できるようにするためのDockerの設定ファイルや各種レポジトリを集めたものです。Dockerとgitをインストールするだけで、好きなエディターでスモウルビーを開発できるようになります。

## 準備

### Dockerのインストール

お使いのOSに合わせて、以下のソフトウェアをインストールしてください。

- Windows: <https://www.docker.com/products/docker-desktop/>
  - Docker をインストールする前に [WSL を使用して Windows に Linux をインストールする方法](https://learn.microsoft.com/ja-jp/windows/wsl/install) に従って WSL (WSL2) をインストールしてください。
- macOS: <https://www.docker.com/products/docker-desktop/>

### Gitのインストールとソースコードのclone

お使いのOSに合わせて、Gitをインストールしてください。

- Windows: <https://gitforwindows.org/>
- macOS: ターミナルアプリを起動して、`xcode-select --install` コマンドを実行後、画面の指示に従ってインストールしてください。

Gitをインストールできたら、次のコマンドを実行してこのレポジトリをcloneします。 `--recursive` を忘れないでください。submoduleをcloneするために必要です。また Windows の場合は C:\Users\<ユーザー名>\source\repos 以下で実行すると良いでしょう。このとき source フォルダとその中の repos フォルダがない場合はそれらを作成してください。

```shell
git config --global core.autocrlf
# (以下、実行結果)
# true
# (↑これを覚えておく)
git config --global core.autocrlf input
git clone --recursive https://github.com/smalruby/smalruby3-develop.git

git config --global core.autocrlf true
# (↑末尾の「true」は先程で覚えておいたもの)
```

もし `--recursive` をつけ忘れたら `git submodule update --init --recursive` を実行すると submodule を clone できます。

## 開発環境の構築

### Dockerイメージの構築

```shell
docker compose build gui
docker compose run --rm gui bash
# (しばらくして、以下のようにbashが起動したらexitコマンドを実行します)
# root@592ae4944bb8:/app/gui/smalruby3-gui# exit
```

Windows で docker-compose build に失敗した場合に `docker system prune -af` で作業途中のイメージをすべて削除してから再度 docker-compose build を行うことで問題を解消できたことがありました。

### スモウルビーの起動

```shell
docker compose up gui
# (以下、実行結果)
# (省略)
# smalruby3-gui_1  | ℹ ｢wdm｣: Compiled successfully.
```

しばらく待ち、↑のように `smalruby3-gui_1  | ℹ ｢wdm｣: Compiled successfully.` と表示されたら OK です。

ウェブブラウザで <http://localhost:8601> を開けばスモウルビー3を操作できます。

これだけで開発環境が整います。

また、デバッグモードで起動するには `--env-file ./config/.env.debug` を指定します。

```shell
docker compose --env-file ./config/.env.debug up gui
# (以下、実行結果)
# (省略)
# smalruby3-gui_1  | ℹ ｢wdm｣: Compiled successfully.
```

### smalruby3-guiの停止

```shell
docker compose stop gui
```

## 開発方法

gui/smalruby3-gui/README.md と gui/scratch-vm/README.md をご覧ください。
