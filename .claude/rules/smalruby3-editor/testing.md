---
paths:
  - "gui/smalruby3-editor/**/test/integration/*.test.js"
  - "gui/smalruby3-editor/**/test/integration/**/*.test.js"
---

# smalruby3-editor テスト規約

## テストフレームワーク

### 使用ツール
- **Jest**: Unit tests
- **Integration tests**: Headless Chrome を使用

### テストディレクトリ構成
- `packages/scratch-gui/test/unit/`: ユニットテスト
- `packages/scratch-gui/test/integration/`: 統合テスト

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

### ビルドコマンド（統合テスト実行前に必須）

```bash
# 開発用ビルド（統合テスト用）
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-editor/packages/scratch-gui && npm run build:dev"

# 本番用ビルド
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-editor/packages/scratch-gui && npm run build"
```

**注意**: 統合テストは `npm run build:dev` でビルドした成果物を使用します。`npm run build` は本番用ビルドで、開発中のテストには `build:dev` を使用してください。

### 全テスト実行

```bash
# lint, unit, build, integration の全てを実行
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-editor/packages/scratch-gui && npm test"
```

### ユニットテスト

```bash
# 全ユニットテスト実行
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-editor/packages/scratch-gui && npm run test:unit"

# 特定のユニットテスト実行
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-editor/packages/scratch-gui && npm exec jest path/to/test.js"
```

### 統合テスト

```bash
# 統合テスト実行（要: 事前にビルド）
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-editor/packages/scratch-gui && npm run test:integration"

# 特定の統合テスト実行（要: 事前にビルド）
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-editor/packages/scratch-gui && npm exec jest test/integration/your-test-file.test.js"
```

## Integration Test Debugging

### ブラウザログの取得

統合テストが失敗した場合、ブラウザのコンソールログを取得してデバッグします。

#### 基本的な使い方

```javascript
import SeleniumHelper from '../helpers/selenium-helper';

const {
    getLogs,
    // ... other helpers
} = new SeleniumHelper();

test('Your test', async () => {
    // ... test code ...

    // テスト失敗時、ブラウザログを取得
    const logs = await getLogs();
    console.log('Browser logs:', logs);
});
```

#### すべてのログレベルを取得（デバッグ用）

デフォルトでは `getLogs()` は SEVERE レベルのログのみを返しますが、デバッグ時にはすべてのログレベル（INFO, WARNING, SEVERE）を取得できます。

```javascript
test('Your test with full logging', async () => {
    // ... test code that may fail ...

    // すべてのログレベルを取得してデバッグ
    const allLogs = await getLogs({includeAllLevels: true});
    console.log('All browser logs:', allLogs);

    // ログの内容を詳細に確認
    allLogs.forEach(log => {
        console.log(`[${log.level}] ${log.message}`);
    });
});
```

#### カスタムwhitelistとの組み合わせ

```javascript
test('Your test with custom filtering', async () => {
    // ... test code ...

    // 特定の警告を除外しつつ、すべてのログレベルを取得
    const debugLogs = await getLogs({
        whitelist: ['Known harmless warning', 'Another expected message'],
        includeAllLevels: true
    });
    console.log('Filtered debug logs:', debugLogs);
});
```

#### デバッグログの活用方法

1. **テストが失敗したら、まず `getLogs({includeAllLevels: true})` を追加**
   - SEVERE以外のログにヒントがある場合があります
   - console.error(), console.warn(), console.log() すべてをキャプチャ

2. **ログレベルで問題を分類**
   ```javascript
   const allLogs = await getLogs({includeAllLevels: true});
   const errors = allLogs.filter(log => log.level === 'SEVERE');
   const warnings = allLogs.filter(log => log.level === 'WARNING');
   const info = allLogs.filter(log => log.level === 'INFO');

   console.log('Errors:', errors.length);
   console.log('Warnings:', warnings.length);
   console.log('Info:', info.length);
   ```

3. **ログの内容をファイルに保存**
   ```javascript
   const allLogs = await getLogs({includeAllLevels: true});
   const fs = require('fs');
   fs.writeFileSync('/tmp/browser-logs.json', JSON.stringify(allLogs, null, 2));
   ```

### デバッグ時のベストプラクティス

1. **再現性の確認**: テストを複数回実行して、毎回同じログが出力されるか確認
2. **ログのタイミング**: テストの各ステップでログを取得し、どの時点で問題が発生するか特定
3. **ブラウザの状態**: `driver.getPageSource()` や `driver.getCurrentUrl()` でブラウザの状態も確認
4. **スクリーンショット**: 必要に応じて `driver.takeScreenshot()` で画面を保存

## Test Implementation Rule

**CRITICAL**: テスト実装時は、コミット・プッシュ前に以下の順序で必ず実行：

1. **ビルド**（統合テストの場合）
   ```bash
   docker compose run --rm gui bash -c "cd /app/gui/smalruby3-editor/packages/scratch-gui && npm run build:dev"
   ```

2. **テスト実行**
   ```bash
   # 特定のテストを実行して成功を確認
   docker compose run --rm gui bash -c "cd /app/gui/smalruby3-editor/packages/scratch-gui && npm exec jest test/integration/your-test.test.js"
   ```

3. **Lint実行**
   ```bash
   docker compose run --rm gui bash -c "cd /app/gui/smalruby3-editor/packages/scratch-gui && npm run test:lint"
   ```

4. **全て成功後のみ**、コミット・プッシュを実行

## テスト作成ガイドライン

### 統合テストの作成
- `test/integration/` ディレクトリに配置
- ファイル名: `*.test.js`
- 実際のユーザー操作に近いシナリオをテスト
- ビルド後の成果物を使用してテスト
- **失敗時のデバッグ**: `getLogs({includeAllLevels: true})` でブラウザログを取得

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
