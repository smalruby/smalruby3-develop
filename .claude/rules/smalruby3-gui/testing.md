---
paths: "gui/smalruby3-gui/test/**/*.{js,jsx}"
---

# smalruby3-gui テスト規約

## テストフレームワーク

### 使用ツール
- **Jest**: Unit tests
- **Integration tests**: Headless Chrome を使用

### テストディレクトリ構成
- `test/unit/`: ユニットテスト
- `test/integration/`: 統合テスト

## TDD Approach

### RED-GREEN-REFACTOR サイクル

1. **RED**: テストを先に書き、失敗することを確認
   - テストが正しい機能をテストしていることを検証
   - テストデータ準備が複雑な場合はユーザーに委任

2. **GREEN**: 実装コードを書き、テストを通す
   - 既存のコードパターンに従う
   - 必要最小限の変更で実装

3. **REFACTOR**: リファクタリング（必要な場合のみ）
   - テストはGREENのまま維持
   - 明示的な要求がない限り、過度なリファクタリングは避ける

## テストコマンド

### 全テスト実行
```bash
# lint, unit, build, integration の全てを実行
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm test"
```

### ユニットテスト
```bash
# 全ユニットテスト実行
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run test:unit"

# 特定のユニットテスト実行
docker compose run --rm gui npm exec jest path/to/test.js
```

### 統合テスト
```bash
# 統合テスト実行（要: 事前にプロダクションビルド）
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run test:integration"

# 特定の統合テスト実行（要: 事前にプロダクションビルド）
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm exec jest test/integration/your-test-file.test.js"
```

## Test Implementation Rule

**CRITICAL**: テスト実装時は、コミット・プッシュ前に以下の順序で必ず実行：

1. **ビルド**（統合テストの場合）
   ```bash
   docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run build"
   ```

2. **テスト実行**
   ```bash
   # 特定のテストを実行して成功を確認
   docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm exec jest test/integration/your-test.test.js"
   ```

3. **Lint実行**
   ```bash
   docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm run test:lint"
   ```

4. **全て成功後のみ**、コミット・プッシュを実行

## テスト作成ガイドライン

### 統合テストの作成
- `test/integration/` ディレクトリに配置
- ファイル名: `*.test.js`
- 実際のユーザー操作に近いシナリオをテスト
- ビルド後の成果物を使用してテスト

### ユニットテストの作成
- コンポーネントやユーティリティ関数の単体テスト
- モックを適切に使用
- 高速に実行できるように設計

## テストデータ

- テストデータの準備が複雑な場合はユーザーに委任
- テストデータは可能な限りシンプルに保つ
- 実際のプロジェクトファイルが必要な場合は、最小限のサイズで準備

## 継続的テスト

リファクタリング時：
- テストは常にGREENを維持
- テストが失敗する場合は、実装の変更を見直す
- テスト自体の修正が必要な場合は、変更の妥当性を確認
