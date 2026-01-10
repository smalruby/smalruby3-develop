---
paths: "gui/scratch-vm/test/**/*.js"
---

# scratch-vm テスト規約

## テストフレームワーク

### 使用ツール
- **TAP (Test Anything Protocol)**: Testing framework
- **Coverage reporting**: コードカバレッジ測定

### テストディレクトリ構成
- `test/unit/`: ユニットテスト
- `test/integration/`: 統合テスト
- `test/fixtures/`: テストデータ・フィクスチャ

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
# 全てのテストを実行
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm test"
```

### ユニットテスト
```bash
# ユニットテストのみ実行
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm run tap:unit"
```

### 統合テスト
```bash
# 統合テストのみ実行
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm run tap:integration"
```

## Test Implementation Rule

**CRITICAL**: テスト実装時は、コミット・プッシュ前に以下の順序で必ず実行：

1. **テスト実行**
   ```bash
   # 特定のテストを実行して成功を確認
   docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm test"
   ```

2. **Lint実行**
   ```bash
   docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm run lint"
   ```

3. **全て成功後のみ**、コミット・プッシュを実行

## テスト作成ガイドライン

### TAPテストの基本構造
```javascript
const test = require('tap').test;

test('description of test', t => {
    // Arrange: テストデータの準備
    const input = 'test data';

    // Act: テスト対象の実行
    const result = functionToTest(input);

    // Assert: 結果の検証
    t.equal(result, expectedValue, 'should return expected value');
    t.end();
});
```

### ユニットテストの作成
- `test/unit/` ディレクトリに配置
- ファイル名: `*.js`
- 個別の関数やクラスメソッドをテスト
- モックを適切に使用して依存関係を分離

### 統合テストの作成
- `test/integration/` ディレクトリに配置
- ファイル名: `*.js`
- 複数のコンポーネントの連携をテスト
- 実際の使用シナリオに近い形でテスト

## テストデータ

### フィクスチャの使用
- `test/fixtures/` にテストデータを配置
- 再利用可能なテストデータはフィクスチャとして管理
- テストデータは可能な限りシンプルに保つ

### テストプロジェクト
- 実際のプロジェクトファイルが必要な場合は、最小限のサイズで準備
- テストデータの準備が複雑な場合はユーザーに委任

## カバレッジ

### コードカバレッジ確認
```bash
# テスト実行時に自動的にカバレッジが計測される
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm test"
```

### カバレッジ目標
- 新規コードは可能な限り高いカバレッジを目指す
- 既存コードの変更時は、変更箇所のカバレッジを維持または向上

## 継続的テスト

リファクタリング時：
- テストは常にGREENを維持
- テストが失敗する場合は、実装の変更を見直す
- テスト自体の修正が必要な場合は、変更の妥当性を確認

## デバッグ

テスト失敗時のデバッグ：
- TAPの出力を確認してエラー箇所を特定
- `console.log` を使用して中間状態を確認
- 必要に応じてブレークポイントを設定
