# GitHub CLI 操作ガイドライン

## 一時ファイルを使用した GitHub CLI 操作

GitHub CLI (`gh` コマンド) で Issue、Pull Request、Commit メッセージを作成する際は、**必ず一時ファイルを使用**してください。

### なぜ一時ファイルを使用するのか

heredoc や引数として直接本文を渡すと、以下の問題が発生します：

1. **バッククォート (`)** のエスケープが複雑
2. **コードブロック** (`\`\`\``) のエスケープが困難
3. **改行** の扱いが環境依存
4. **特殊文字** ($, ", ', \, など) のエスケープが必要
5. **長文** の可読性が低下
6. **デバッグ** が困難

一時ファイルを使用することで、これらの問題を回避し、マークダウンをそのまま記述できます。

## Issue 作成

### 手順

1. 一時ファイルに Issue 本文を作成
2. `gh issue create` で一時ファイルを指定
3. Issue 作成後、一時ファイルを削除（オプション）

### コマンド例

```bash
# 1. 一時ファイルに Issue 本文を作成
cat > /tmp/issue-body.md <<'EOF'
## 概要

AppSync の WebSocket エンドポイントにカスタムドメイン `graphql.smalruby.app` を設定します。

## タスク

### 1. 環境変数の設定

`infra/mesh-v2/.env.example` に以下を追加：

```bash
APPSYNC_CUSTOM_DOMAIN=graphql.smalruby.app
```

### 2. CDK実装

```typescript
const customDomain = process.env.APPSYNC_CUSTOM_DOMAIN || '';
```

## 完了条件

- [ ] 環境変数の設定完了
- [ ] CDK実装の完了
EOF

# 2. Issue を作成
gh issue create \
  --repo smalruby/smalruby3-develop \
  --title "AppSync WebSocket カスタムドメイン設定" \
  --body-file /tmp/issue-body.md

# 3. 一時ファイルを削除（オプション）
rm /tmp/issue-body.md
```

### Write ツールを使用する場合

```bash
# Write ツールで一時ファイルを作成後、gh コマンドを実行
gh issue create \
  --repo smalruby/smalruby3-develop \
  --title "Title" \
  --body-file /tmp/issue-body.md
```

## Issue 更新

### 手順

1. 一時ファイルに更新後の Issue 本文を作成
2. `gh issue edit` で一時ファイルを指定

### コマンド例

```bash
# 1. 一時ファイルに更新後の本文を作成
cat > /tmp/issue-update.md <<'EOF'
## 更新された概要

新しい情報を追加しました。

```bash
# 新しいコマンド例
npm run build
```
EOF

# 2. Issue を更新
gh issue edit 10 \
  --repo smalruby/smalruby3-develop \
  --body-file /tmp/issue-update.md

# 3. 一時ファイルを削除
rm /tmp/issue-update.md
```

## Pull Request 作成

### 手順

1. 一時ファイルに PR 本文を作成
2. `gh pr create` で一時ファイルを指定

### コマンド例

```bash
# 1. 一時ファイルに PR 本文を作成
cat > /tmp/pr-body.md <<'EOF'
## Summary

AppSync にカスタムドメイン設定を追加しました。

## Implementation Details

- `GraphqlApi` の `domainName` プロパティを使用
- ACM 証明書は環境変数から取得
- カスタムドメインが設定されている場合のみ有効化

## Test Coverage

```bash
# デプロイテスト
npx cdk deploy --context stage=stg
```

## Usage Example

```typescript
// 環境変数設定
APPSYNC_CUSTOM_DOMAIN=graphql.smalruby.app
APPSYNC_CERTIFICATE_ARN=arn:aws:acm:...
```

Fixes #10
EOF

# 2. PR を作成
gh pr create \
  --repo smalruby/smalruby3-develop \
  --base main \
  --title "feat: add AppSync custom domain support" \
  --body-file /tmp/pr-body.md

# 3. 一時ファイルを削除
rm /tmp/pr-body.md
```

## Commit メッセージ

### 手順

1. 一時ファイルに Commit メッセージを作成
2. `git commit -F` で一時ファイルを指定

### コマンド例

```bash
# 1. 一時ファイルに Commit メッセージを作成
cat > /tmp/commit-msg.txt <<'EOF'
feat: add AppSync custom domain support

- Added domainName configuration to GraphqlApi
- Import ACM certificate from environment variable
- Output custom domain endpoints when configured

Implementation details:
- Certificate must be in the same region as AppSync API
- Custom domain is optional (controlled by env var)
- Outputs AppSyncDomainName for Route53 CNAME setup

Example configuration:
```bash
APPSYNC_CUSTOM_DOMAIN=graphql.smalruby.app
APPSYNC_CERTIFICATE_ARN=arn:aws:acm:ap-northeast-1:xxx:certificate/xxx
```

Fixes #10

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
EOF

# 2. Commit を作成
git commit -F /tmp/commit-msg.txt

# 3. 一時ファイルを削除
rm /tmp/commit-msg.txt
```

## エスケープが必要な文字の例

heredoc で直接記述する場合、以下の文字はエスケープが必要：

| 文字 | 問題 | heredoc でのエスケープ | 一時ファイルでの扱い |
|------|------|------------------------|---------------------|
| ` | コードブロック終了と誤認識 | `\`` | エスケープ不要 |
| $ | 変数展開される | `\$` または `'EOF'` | エスケープ不要 |
| " | 文字列終了と誤認識 | `\"` | エスケープ不要 |
| \ | エスケープ文字 | `\\` | エスケープ不要 |
| ' | heredoc の種類によっては問題 | heredoc を `'EOF'` に | エスケープ不要 |

**結論**: 一時ファイルを使用すれば、すべてのマークダウンをそのまま記述できます。

## ベストプラクティス

### 1. 一時ファイルの配置

```bash
# 推奨: /tmp ディレクトリを使用（自動的にクリーンアップされる）
/tmp/issue-body.md
/tmp/pr-body.md
/tmp/commit-msg.txt

# 代替: プロジェクトの tmp ディレクトリ（.gitignore に含まれている）
tmp/issue-body.md
tmp/pr-body.md
```

### 2. 一時ファイルの命名

わかりやすい命名規則を使用：

```bash
/tmp/issue-${ISSUE_NUMBER}-body.md
/tmp/pr-${BRANCH_NAME}-body.md
/tmp/commit-$(date +%Y%m%d-%H%M%S).txt
```

### 3. Write ツールの活用

Claude Code の Write ツールで一時ファイルを作成すると、内容を事前に確認できます：

```bash
# 1. Write ツールで /tmp/issue-body.md を作成
# 2. ユーザーが内容を確認
# 3. gh コマンドで Issue 作成
```

### 4. クリーンアップ

一時ファイルは作成後に削除するか、`/tmp` ディレクトリを使用して自動クリーンアップに任せます：

```bash
# 明示的に削除
rm /tmp/issue-body.md

# または /tmp を使用（再起動時に自動削除される）
```

## 禁止事項

以下の方法は**使用しないでください**：

### ❌ heredoc で直接 gh コマンドに渡す

```bash
# これは使わない - エスケープが複雑
gh issue create --body "$(cat <<'EOF'
コードブロック ```bash を含む本文
EOF
)"
```

### ❌ 引数として直接本文を渡す

```bash
# これは使わない - 長文の場合読みにくい
gh issue create --body "## 概要\n\n本文..."
```

### ❌ heredoc をパイプで渡す

```bash
# これは使わない - エスケープが必要
cat <<'EOF' | gh issue create --body-file -
EOF
```

## まとめ

**常に一時ファイルを使用する理由**：

1. ✅ エスケープ不要
2. ✅ マークダウンをそのまま記述可能
3. ✅ 可読性が高い
4. ✅ デバッグが容易
5. ✅ ユーザーが内容を事前確認できる
6. ✅ 再利用しやすい

**推奨ワークフロー**：

```bash
# 1. Write ツールで一時ファイル作成
# 2. gh コマンドで --body-file オプションを使用
# 3. 必要に応じて一時ファイルを削除
```

この方法により、GitHub CLI 操作が確実で保守性の高いものになります。
