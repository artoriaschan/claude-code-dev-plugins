#!/bin/bash
# 安装所有插件的 rules 到 ~/.claude/rules/
# 扫描 plugins/ 下所有包含 rules/ 目录的插件，将规则同步到本地。
#
# 用法:
#   本地:   ./install.sh
#   本地:   bash install.sh
#   远程:   curl -fsSL https://raw.githubusercontent.com/artoriaschan/claude-code-dev-plugins/main/install.sh | bash

set -e

REPO_OWNER="artoriaschan"
REPO_NAME="claude-code-dev-plugins"
BRANCH="main"
PLUGINS_DIR="plugins"
TARGET_BASE="$HOME/.claude/rules"

RAW_BASE="https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/${BRANCH}"

# 解析脚本目录（本地文件和 curl 管道均适用）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"

echo "正在扫描 plugins/ 下所有插件的 rules..."

# 收集含有 rules/ 目录的插件名称
if [ -d "$SCRIPT_DIR/$PLUGINS_DIR" ] && [ -f "$SCRIPT_DIR/$PLUGINS_DIR/code-style/.claude-plugin/plugin.json" ]; then
  # 本地模式：直接遍历目录
  PLUGIN_NAMES=()
  for plugin_dir in "$SCRIPT_DIR/$PLUGINS_DIR"/*/; do
    if [ -d "$plugin_dir/rules" ]; then
      name=$(basename "$plugin_dir")
      PLUGIN_NAMES+=("$name")
    fi
  done
  SOURCE_MODE="local"
else
  # 远程模式：通过 GitHub API 获取插件列表
  echo "从 GitHub 获取插件列表: ${REPO_OWNER}/${REPO_NAME}/${BRANCH}"
  API_URL="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/contents/${PLUGINS_DIR}?ref=${BRANCH}"
  PLUGIN_NAMES=()
  while IFS= read -r name; do
    PLUGIN_NAMES+=("$name")
  done < <(curl -fsSL "$API_URL" | grep -oP '"name":\s*"\K[^"]+' || true)
  SOURCE_MODE="remote"
fi

if [ ${#PLUGIN_NAMES[@]} -eq 0 ]; then
  echo "未找到包含 rules/ 的插件。"
  exit 0
fi

echo "发现 ${#PLUGIN_NAMES[@]} 个插件: ${PLUGIN_NAMES[*]}"
echo ""

INSTALLED_COUNT=0

for plugin_name in "${PLUGIN_NAMES[@]}"; do
  RULES_SUBDIR="${PLUGINS_DIR}/${plugin_name}/rules"

  if [ "$SOURCE_MODE" = "local" ]; then
    SOURCE_DIR="$SCRIPT_DIR/$RULES_SUBDIR"
    if [ ! -d "$SOURCE_DIR" ]; then
      continue
    fi
    TARGET_DIR="$TARGET_BASE/$plugin_name"

    # 移除已有的符号链接或目录
    if [ -L "$TARGET_DIR" ]; then
      rm "$TARGET_DIR"
    elif [ -d "$TARGET_DIR" ]; then
      rm -rf "$TARGET_DIR"
    fi

    mkdir -p "$TARGET_BASE"
    cp -r "$SOURCE_DIR" "$TARGET_DIR"
    echo "  ✓ $plugin_name → $TARGET_DIR"
    INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
  else
    # 远程模式：检查插件是否含 rules/ 目录
    CHECK_URL="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/contents/${RULES_SUBDIR}?ref=${BRANCH}"
    if ! curl -fsSL -o /dev/null "$CHECK_URL" 2>/dev/null; then
      continue
    fi

    TMP_DIR=$(mktemp -d)
    trap 'rm -rf "$TMP_DIR"' EXIT

    # 递归下载 rules 子目录
    RULES_URL="${RAW_BASE}/${RULES_SUBDIR}"
    DOWNLOAD_DIR="$TMP_DIR/$plugin_name"
    mkdir -p "$DOWNLOAD_DIR"

    # 获取 rules/ 下的一级子目录
    SUBDIRS=$(curl -fsSL "$CHECK_URL" | grep -oP '"name":\s*"\K[^"]+' || true)
    for subdir in $SUBDIRS; do
      SUBDIR_API="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/contents/${RULES_SUBDIR}/${subdir}?ref=${BRANCH}"
      # 判断是文件还是目录
      SUBDIR_TYPE=$(curl -fsSL "$SUBDIR_API" 2>/dev/null | head -1 | grep -oP '"type":\s*"\K[^"]+' || true)
      if [ "$SUBDIR_TYPE" = "dir" ]; then
        mkdir -p "$DOWNLOAD_DIR/$subdir"
        files=$(curl -fsSL "$SUBDIR_API" | grep -oP '"name":\s*"\K[^"]+\.md' || true)
        for f in $files; do
          curl -fsSL "${RULES_URL}/${subdir}/${f}" -o "$DOWNLOAD_DIR/$subdir/${f}" || echo "  警告: 下载 ${plugin_name}/${subdir}/${f} 失败"
        done
      elif [ "$SUBDIR_TYPE" = "file" ]; then
        # 直接在 rules/ 下的文件
        curl -fsSL "${RULES_URL}/${subdir}" -o "$DOWNLOAD_DIR/${subdir}" || echo "  警告: 下载 ${plugin_name}/${subdir} 失败"
      fi
    done

    TARGET_DIR="$TARGET_BASE/$plugin_name"
    if [ -L "$TARGET_DIR" ]; then
      rm "$TARGET_DIR"
    elif [ -d "$TARGET_DIR" ]; then
      rm -rf "$TARGET_DIR"
    fi

    mkdir -p "$TARGET_BASE"
    cp -r "$DOWNLOAD_DIR" "$TARGET_DIR"
    rm -rf "$TMP_DIR"
    echo "  ✓ $plugin_name → $TARGET_DIR"
    INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
  fi
done

echo ""
echo "安装完成！共安装 ${INSTALLED_COUNT} 个插件的 rules。"
