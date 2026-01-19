# Smalruby 3 Monorepo Migration Progress (Phase 3)

## 実施済み作業

### Phase 3.1: Opal 統合
- `opal/` ディレクトリ全体を `packages/scratch-gui/` にコピー
- `scripts/make-setup-opal.js` をコピー
- `package.json` に `setup:opal` と `prebuild` スクリプトを追加
- `webpack.config.js` に `opal-loader`、alias (`opal`, `opal-parser`)、`.mjs` ルールを追加
- `npm install` により `shelljs`, `opal-loader` を追加

### Phase 3.2: Ruby to Blocks Converter 移行
- `src/lib/ruby-to-blocks-converter/` の全29ファイルをコピー
- `src/lib/ruby-parser.js` をコピー
- `ruby-parser.js` の Opal 初期化ロジックを Node.js/Jest 環境向けに修正
    - `Opal.load` を追加し、`Opal.Parser.Ruby31` が正しく初期化されるように対応
- ユニットテスト (`test/unit/lib/ruby-to-blocks-converter/`) をコピー

### Phase 3.3: カスタムコンポーネント 移行
- 以下のコンポーネント/コンテナを移行:
    - `mesh-domain-modal`
    - `koshien-test-modal`
    - `block-display-modal`
    - `url-loader-modal`
    - `google-drive-save-dialog`
    - `ruby-tab` (container & snippets)
- 以下の Reducer を移行・統合:
    - `mesh-v2`, `block-display`, `google-drive-file`, `koshien-file`, `ruby-code`
- `reducers/modals.js`, `reducers/menus.js`, `reducers/gui.ts` を Smalruby 仕様に更新
- `gui.jsx`, `menu-bar.jsx` を Smalruby 仕様（Rubyタブ、各メニュー項目）に更新
- `react-intl` の `intlShape` 消失に伴い、ローカルの `src/lib/intlShape.js` 参照に修正

### Phase 3.4: ビルドスクリプト 移行
- `postbuild.mjs`, `prepublish.mjs`, `makePWAAssetsManifest.js` を移行
- `package.json` の `build` スクリプトを Smalruby の後処理を含むように強化
- `.gitignore` を更新し、`src/generated/` や `static/microbit/` を除外
- `npm install` により `cross-fetch`, `yauzl` を追加

---

## 現状の課題 (Current Issues)

- **未使用 Props**: `gui.jsx` において一部の Smalruby 用 Props が定義されているが、ロジックへの接続が未完了。

---

## 次のステップ (TODO)

1. **ユニットテストの完全パス**
    - [x] `docker compose run --rm gui bash -c "cd /app/gui/smalruby3-editor/packages/scratch-gui && npm exec jest test/unit/lib/ruby-to-blocks-converter/ruby.test.js"` を実行し、修正を確認する。
    - [x] `ruby-to-blocks-converter/` 全体のテストを実行。

2. **UI 動作確認**
    - [ ] 開発サーバーを起動し、メニュー項目（Rubyの生成、Mesh設定、甲子園テスト等）から各モーダルが正常に開くことを確認。
    - [ ] Ruby タブが表示され、Monaco Editor が正常にロードされるか確認。

3. **コード品質チェック**
    - [ ] `npm run test:lint` を実行し、残っている警告やエラーを修正。

4. **ビルド確認**
    - [ ] `npm run build` を実行し、production ビルドが最後まで成功することを確認。
    - [ ] `postbuild.mjs` による `fetch-worker` のパス置換が正しく行われているか、生成された JS を確認。