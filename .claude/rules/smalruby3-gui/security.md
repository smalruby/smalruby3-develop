---
paths: "gui/smalruby3-gui/src/**/*.{js,jsx}"
---

# smalruby3-gui セキュリティ要件

## セキュリティ脆弱性の防止

コード実装時は、以下のセキュリティ脆弱性に注意してください。

### OWASP Top 10 対策

#### 1. Injection（インジェクション）
- **Command Injection**: システムコマンド実行時の入力検証
- **XSS (Cross-Site Scripting)**: ユーザー入力の適切なエスケープ
- **SQL Injection**: データベースクエリのパラメータ化（該当する場合）

#### 2. XSS (Cross-Site Scripting)
- ユーザー入力を DOM に挿入する前にサニタイズ
- `dangerouslySetInnerHTML` の使用を最小限に
- React の自動エスケープ機能を活用

#### 3. 不適切な認証とセッション管理
- Google Drive OAuth トークンの安全な管理
- セッション情報をローカルストレージに保存する際の暗号化検討

#### 4. 安全でない直接オブジェクト参照
- ファイルアクセス時のパス検証
- ユーザーが指定したファイルパスの正規化とバリデーション

#### 5. セキュリティ設定のミス
- CORS ポリシーの適切な設定
- Content Security Policy (CSP) の設定確認
- 開発環境と本番環境の設定分離

## 実装時のセキュリティチェックリスト

### 入力検証
- [ ] すべてのユーザー入力を検証
- [ ] ホワイトリスト方式での検証を優先
- [ ] 型チェックと範囲チェック

### 出力エスケープ
- [ ] HTMLコンテキストでのエスケープ
- [ ] JavaScriptコンテキストでのエスケープ
- [ ] URLコンテキストでのエンコード

### データ保護
- [ ] 機密情報をログに出力しない
- [ ] ブラウザのローカルストレージに機密情報を保存しない
- [ ] OAuth トークンの適切な管理

### エラーハンドリング
- [ ] エラーメッセージに機密情報を含めない
- [ ] スタックトレースを本番環境で表示しない
- [ ] ユーザーフレンドリーなエラーメッセージ

## React特有のセキュリティ考慮事項

### dangerouslySetInnerHTML
```javascript
// 避けるべき
<div dangerouslySetInnerHTML={{__html: userInput}} />

// 代わりに
import DOMPurify from 'dompurify';
<div dangerouslySetInnerHTML={{__html: DOMPurify.sanitize(userInput)}} />
```

### イベントハンドラでの実行
```javascript
// 避けるべき
<button onClick={() => eval(userInput)}>Click</button>

// 安全な実装
<button onClick={handleClick}>Click</button>
```

## 外部ライブラリの使用

### 依存関係の管理
- 定期的に `npm audit` を実行
- 脆弱性が報告された依存関係を速やかに更新
- 不要な依存関係を削除

### サードパーティスクリプト
- Google API など、信頼できるソースからのみ読み込み
- Subresource Integrity (SRI) の使用を検討

## コードレビュー時の確認事項

コードレビュー時は以下を確認：
- [ ] ユーザー入力の検証が適切に行われているか
- [ ] XSS脆弱性がないか
- [ ] 機密情報が適切に保護されているか
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
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm audit"

# 自動修正可能な脆弱性を修正
docker compose run --rm gui bash -c "cd /app/gui/smalruby3-gui && npm audit fix"
```
