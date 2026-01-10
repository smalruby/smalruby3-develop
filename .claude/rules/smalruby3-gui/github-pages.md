---
paths:
  - "gui/smalruby3-gui/scripts/postbuild.mjs"
  - "gui/smalruby3-gui/webpack.config.js"
---

# GitHub Pages publicPath ローカルテスト

GitHub Pages サブディレクトリデプロイメント（例: `/smalruby3-gui/` パス）をローカルでテストする際のワークフローです。

## 1. PUBLIC_PATHを指定してビルド

```bash
# GitHub Pages サブディレクトリパスでビルド（workerパスは自動修正される）
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && PUBLIC_PATH=/smalruby3-gui/ npm run build"
```

**注意**: ビルドプロセスには自動化されたpost-buildスクリプト（`scripts/postbuild.mjs`）が含まれており、`PUBLIC_PATH` 環境変数を検出してfetch-workerパスを自動的に修正します。手動での `sed`/`gsed` コマンドは不要です。

## 2. テスト環境のセットアップ

```bash
# テストディレクトリ構造を作成
mkdir -p /private/tmp/github-pages-test/smalruby3-gui

# ビルド出力をテスト構造にコピー
cp -R gui/smalruby3-gui/build/* /private/tmp/github-pages-test/smalruby3-gui/

# Python HTTPサーバーを起動
cd /private/tmp/github-pages-test
python3 -m http.server 8080
```

## 3. テストURL

以下のURLでテスト：
- **メインページ**: `http://localhost:8080/smalruby3-gui/`
- **日本語ページ**: `http://localhost:8080/smalruby3-gui/ja.html`
- **プレイヤーページ**: `http://localhost:8080/smalruby3-gui/player.html`

## 4. 機能確認

1. ブラウザの開発者ツール（F12）を開く → Networkタブ
2. スプライト選択ボタン（右下の猫アイコン）をクリック
3. `fetch-worker.xxxxx.js` が `/smalruby3-gui/chunks/` パスから読み込まれることを確認
4. workerファイルに404エラーがないことを確認
5. スプライトライブラリが正しく読み込まれることをテスト

## 背景情報

このワークフローは、GitHub Pagesデプロイメント環境をローカルでテスト・デバッグするために使用します。

### PUBLIC_PATH環境変数の役割
- webpack設定で `publicPath` を動的に変更
- すべてのアセット（JS、CSS、画像等）のパスが `/smalruby3-gui/` プレフィックス付きで生成される
- post-buildスクリプトがworkerパスを自動的に調整

### なぜローカルテストが必要か
- GitHub Pagesへのデプロイ前に問題を発見
- workerファイルのパス問題を事前に検証
- サブディレクトリデプロイメント特有の問題を確認
