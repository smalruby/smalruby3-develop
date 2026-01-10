---
paths: "gui/smalruby3-gui/**/*"
---

# smalruby3-gui Git/GitHub運用

## Default Branch

**IMPORTANT**: このリポジトリは `develop` ブランチがデフォルトです（`main` ではありません）。

## Branch Creation Rules

### 作業開始前の確認
1. **現在のブランチを確認**: `git branch` で現在のブランチを確認
2. **developへの直接コミット禁止**: `develop` ブランチにいる場合は、必ずfeature branchを作成
3. **Feature branch命名規則**: 以下のような記述的な名前を使用
   - `fix/issue-description` - バグ修正
   - `feature/new-functionality` - 新機能
   - `refactor/description` - リファクタリング

### 推奨ワークフロー

```bash
# 現在のブランチを確認
cd gui/smalruby3-gui
git branch

# developブランチにいる場合、feature branchを作成
git checkout -b fix/your-issue-description

# 変更を加えてコミット
git add .
git commit -m "your commit message"

# Feature branchをプッシュ
git push origin fix/your-issue-description

# PRを作成（developブランチをターゲット）
gh pr create --repo smalruby/smalruby3-gui --base develop --head fix/your-issue-description
```

### なぜこれが重要か
- `develop` ブランチにはリポジトリルールが設定されており、直接プッシュができない可能性がある
- Feature branchを使用することで、適切なコードレビューとCI/CDプロセスが可能になる
- 標準的なGit Flow開発ワークフローに従う

## GitHub Operations

### 正しいリポジトリURL
- **smalruby3-gui**: https://github.com/smalruby/smalruby3-gui

### 間違ったリポジトリURL（使用禁止）
- ❌ https://github.com/scratchfoundation/scratch-gui

### コマンド例

```bash
# 正しい - Smalrubyリポジトリでissue作成
gh issue create --repo smalruby/smalruby3-gui --title "Issue title" --body "Issue body"

# 正しい - SmalrubyリポジトリでPR作成
gh pr create --repo smalruby/smalruby3-gui --base develop --title "PR title" --body "PR body"

# 間違い - Scratch Foundationリポジトリへの操作は避ける
gh issue create --repo scratchfoundation/scratch-gui  # これは実行しないこと
```

**重要**: すべてのGitHub操作（issue、pull request、コメント等）は、Smalruby organizationのリポジトリに対して行う必要があります。upstream の Scratch Foundation リポジトリに対しては行わないでください。

## Commit Message Format

### 基本フォーマット
```
feat: descriptive commit message

Details about the implementation, including:
- What functionality was added/changed
- How it works
- Any important implementation details

Fixes #issue-number

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

### プレフィックス
- `feat:` - 新機能
- `fix:` - バグ修正
- `refactor:` - リファクタリング
- `test:` - テスト追加・修正
- `docs:` - ドキュメント
- `chore:` - ビルドプロセスや補助ツールの変更

## Pull Request Guidelines

PRの説明には以下を含める：

### 必須項目
- **Summary**: 変更の簡潔な概要
- **Implementation details**: 機能の動作方法
- **Test coverage**: 追加・修正されたテスト
- **Usage examples**: コードスニペットまたはURL例

### オプション項目
- **Breaking changes**: ある場合（マイグレーションガイド付き）
- **Screenshots**: UI変更の場合
- **Related issues**: 関連するissue番号

### PR作成コマンド
```bash
gh pr create \
  --repo smalruby/smalruby3-gui \
  --base develop \
  --head feature/descriptive-name \
  --title "Title" \
  --body "Detailed description including implementation details, test coverage, and usage examples"
```

## マージ後の作業

PR が手動でマージされた後：
1. ローカルの `develop` ブランチを更新: `git checkout develop && git pull`
2. 不要なfeature branchを削除: `git branch -d feature/descriptive-name`
