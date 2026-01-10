---
paths: "gui/scratch-vm/src/**/*.js"
---

# scratch-vm コードスタイル

## コーディング規約

### 基本方針
- 既存コードパターンに従う
- Scratch 3.0のフォーク元パターンを尊重
- JavaScript標準のベストプラクティスに従う

### 避けるべきパターン
- 不要な抽象化や過度な最適化
- 明示的な要求がない限り、機能追加やリファクタリングは行わない
- 使用されていないコードには後方互換性のためのハックを追加しない
- 使用されていないものは完全に削除する

## Lint

### ESLint設定
- プロジェクトの `.eslintrc.js` 設定を使用
- Scratch 3.0 upstream からの設定を継承

### Lintコマンド

#### Lint実行
```bash
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm run lint"
```

## コーディングスタイル

### 命名規則
- クラス名: PascalCase (例: `VirtualMachine`)
- 関数名: camelCase (例: `executeBlock`)
- 定数: UPPER_SNAKE_CASE (例: `MAX_CLONE_COUNT`)
- プライベートメソッド: アンダースコアプレフィックス (例: `_privateMethod`)

### コメント
- JSDocを使用してAPI文書化
- 複雑なロジックには説明コメントを追加
- 自明なコードにはコメント不要

### 関数設計
- 単一責任の原則に従う
- 関数は短く保つ（目安: 50行以内）
- 副作用を最小限に

## コードレビューチェックリスト

コード修正時は以下を確認：
- [ ] Lintエラーがないこと
- [ ] 既存のコードパターンに従っているか
- [ ] 不要な抽象化を追加していないか
- [ ] セキュリティ上の問題がないか
- [ ] テストが通ることを確認したか
- [ ] ドキュメント更新が必要な変更か

## ドキュメント生成

コード変更後、必要に応じてドキュメントを更新：
```bash
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm run docs"
```
