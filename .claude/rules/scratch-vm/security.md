---
paths: "gui/scratch-vm/src/**/*.js"
---

# scratch-vm セキュリティ要件

## セキュリティ脆弱性の防止

コード実装時は、以下のセキュリティ脆弱性に注意してください。

### OWASP Top 10 対策

#### 1. Injection（インジェクション）
- **Command Injection**: 外部コマンド実行時の入力検証
- **Code Injection**: `eval()` などの動的コード実行の使用を避ける
- **XSS**: VMが生成する出力の適切なエスケープ

#### 2. セキュリティ設定のミス
- デフォルトで安全な設定を使用
- 開発環境と本番環境の設定分離
- エラーメッセージに機密情報を含めない

#### 3. 安全でない直接オブジェクト参照
- ユーザーが指定するリソースへのアクセス制御
- パストラバーサル攻撃の防止

## 実装時のセキュリティチェックリスト

### 入力検証
- [ ] すべてのユーザー入力（ブロック引数、プロジェクトデータ等）を検証
- [ ] ホワイトリスト方式での検証を優先
- [ ] 型チェックと範囲チェック
- [ ] 文字列長の制限

### コード実行の安全性
- [ ] `eval()` の使用を避ける
- [ ] `Function()` コンストラクタの安全な使用
- [ ] サンドボックス化された実行環境の維持

### リソース制限
- [ ] 無限ループの検出と防止
- [ ] メモリ使用量の制限
- [ ] スタックオーバーフローの防止
- [ ] クローン数の制限

### エラーハンドリング
- [ ] エラーメッセージに機密情報を含めない
- [ ] スタックトレースを本番環境で表示しない
- [ ] ユーザーフレンドリーなエラーメッセージ

## VM特有のセキュリティ考慮事項

### ブロック実行の安全性
```javascript
// 避けるべき
execute(blockCode) {
    eval(blockCode); // 危険！
}

// 安全な実装
execute(blockId) {
    const blockFunction = this.getBlockFunction(blockId);
    if (typeof blockFunction === 'function') {
        return blockFunction();
    }
}
```

### プロジェクトデータの検証
```javascript
// プロジェクトデータ読み込み時
loadProject(projectData) {
    // データ構造の検証
    if (!this.validateProjectStructure(projectData)) {
        throw new Error('Invalid project data');
    }

    // サニタイゼーション
    const sanitizedData = this.sanitizeProjectData(projectData);

    // 読み込み
    this._loadSanitizedProject(sanitizedData);
}
```

### 拡張機能の安全性
- 拡張機能のサンドボックス化
- 拡張機能の権限管理
- 信頼できるソースからのみ拡張機能を読み込む

## リソース制限

### メモリ制限
```javascript
const MAX_CLONE_COUNT = 300;
const MAX_LIST_SIZE = 200000;
const MAX_STRING_LENGTH = 10000;

// 制限チェック
if (cloneCount >= MAX_CLONE_COUNT) {
    throw new Error('Too many clones');
}
```

### 実行時間制限
```javascript
// 無限ループ検出
const startTime = Date.now();
const MAX_EXECUTION_TIME = 5000; // 5秒

while (condition) {
    if (Date.now() - startTime > MAX_EXECUTION_TIME) {
        throw new Error('Execution timeout');
    }
    // ループ処理
}
```

## 外部リソースへのアクセス

### ネットワークアクセス
- HTTPSを優先
- URLの検証とサニタイゼーション
- CORS ポリシーの遵守
- レート制限の実装

### ファイルアクセス
- ファイルパスの正規化
- パストラバーサル攻撃の防止
- 許可されたディレクトリのみアクセス

## コードレビュー時の確認事項

コードレビュー時は以下を確認：
- [ ] ユーザー入力の検証が適切に行われているか
- [ ] `eval()` や動的コード実行が使用されていないか
- [ ] リソース制限が適切に実装されているか
- [ ] エラーハンドリングが適切か
- [ ] 新しい依存関係に既知の脆弱性がないか

## セキュリティ問題の報告

セキュリティ脆弱性を発見した場合：
1. 公開のissueとして報告しない
2. プロジェクトメンテナーに直接連絡
3. 修正が完了するまで詳細を公開しない

## 自動セキュリティチェック

実装時に気づいた不適切なコードは、すぐに修正してください：

```bash
# npm audit実行
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm audit"

# 自動修正可能な脆弱性を修正
docker compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm audit fix"
```

## セキュリティテスト

セキュリティ関連の変更を行った場合：
- 境界値テストを実施
- 異常系のテストを追加
- リソース制限のテストを実施
- サンドボックスの動作確認
