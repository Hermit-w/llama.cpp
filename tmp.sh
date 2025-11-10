#!/bin/bash

export HF_ENDPOINT="https://hf-mirror.com"

# 检查是否提供了模型名称参数
if [ $# -eq 0 ]; then
    echo "错误：请提供模型名称"
    echo "使用方法: bash $0 <organization>/<model-name>"
    echo "示例: bash $0 deepseek-ai/deepseek-R1"
    exit 1
fi

# 获取模型名称参数
MODEL_NAME="$1"

# 检查参数格式是否包含斜杠
if [[ "$MODEL_NAME" != *"/"* ]]; then
    echo "错误：模型名称格式不正确，应该为 organization/model-name"
    echo "示例: deepseek-ai/deepseek-R1"
    exit 1
fi

# 按斜杠分割模型名称
ORG_NAME=$(echo "$MODEL_NAME" | cut -d'/' -f1)
MODEL_DIR_NAME=$(echo "$MODEL_NAME" | cut -d'/' -f2)

# 创建目录路径
TARGET_DIR="${ORG_NAME}/${MODEL_DIR_NAME}"

echo "开始下载模型: $MODEL_NAME"
echo "目标目录: $TARGET_DIR"

# 创建目录（如果不存在）
mkdir -p "$TARGET_DIR"

# 检查 huggingface-cli 是否可用
if ! command -v huggingface-cli &> /dev/null; then
    echo "错误: huggingface-cli 未安装或不在 PATH 中"
    echo "请先安装: pip install huggingface_hub"
    exit 1
fi

# 下载模型到指定目录
echo "正在下载模型..."
hf download "$MODEL_NAME" --local-dir "$TARGET_DIR"

# 检查下载是否成功
if [ $? -eq 0 ]; then
    echo "✅ 模型下载完成！"
    echo "📁 模型保存在: $TARGET_DIR"
else
    echo "❌ 模型下载失败！"
    exit 1
fi