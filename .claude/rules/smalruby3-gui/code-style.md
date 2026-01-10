---
paths: "gui/smalruby3-gui/src/**/*.{js,jsx}"
---

# smalruby3-gui コードスタイル

## コーディング規約

### 基本方針
- 既存コードパターンに従う
- Scratch 3.0のフォーク元パターンを尊重
- React コンポーネントの命名規則に従う

### 避けるべきパターン
- 不要な抽象化や過度な最適化
- 明示的な要求がない限り、機能追加やリファクタリングは行わない
- 使用されていないコードには後方互換性のためのハックを追加しない（例: 未使用変数の `_vars` へのリネーム、削除されたコードへの `// removed` コメント等）
- 使用されていないものは完全に削除する

## Lint

### ESLint設定
- プロジェクトの `.eslintrc.js` 設定を使用
- Scratch 3.0 upstream からの設定を継承

### Lintコマンド

#### 全ファイルのLint実行
```bash
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run test:lint"
```

#### 特定ファイルのLint実行
```bash
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm exec eslint your-file1.js your-file2.js"
```

#### 特定ファイルのLint自動修正
```bash
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm exec eslint --fix your-file1.js your-file2.js"
```

## コードレビューチェックリスト

コード修正時は以下を確認：
- [ ] ESLintエラーがないこと
- [ ] 既存のコードパターンに従っているか
- [ ] 不要な抽象化を追加していないか
- [ ] セキュリティ上の問題がないか
- [ ] テストが通ることを確認したか
