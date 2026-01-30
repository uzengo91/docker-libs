#!/bin/bash

# Docker 镜像打包并上传到 OSS 的脚本
# 用法: ./docker-tar.sh <docker_url> <output_filename>
# 示例: ./docker-tar.sh registry.example.com/image:latest video.tar.gz

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 参数检查
if [ $# -lt 2 ]; then
    echo -e "${RED}错误: 参数不足${NC}"
    echo "用法: $0 <docker_url> <output_filename>"
    echo "示例: $0 registry.example.com/image:latest video.tar.gz"
    exit 1
fi

DOCKER_URL="$1"
OUTPUT_FILE="$2"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${YELLOW}======== Docker 镜像打包和上传脚本 ========${NC}"
echo "Docker 镜像地址: $DOCKER_URL"
echo "输出文件名: $OUTPUT_FILE"

# 第一步: 拉取 Docker 镜像
echo -e "${YELLOW}\n[1/3] 拉取 Docker 镜像...${NC}"
if docker pull "$DOCKER_URL"; then
    echo -e "${GREEN}✓ 镜像拉取成功${NC}"
else
    echo -e "${RED}✗ 镜像拉取失败${NC}"
    exit 1
fi

# 第二步: 保存并压缩镜像
echo -e "${YELLOW}\n[2/3] 保存并压缩镜像...${NC}"
if docker save "$DOCKER_URL" | gzip > "$OUTPUT_FILE"; then
    FILE_SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)
    echo -e "${GREEN}✓ 镜像压缩成功${NC}"
    echo "文件路径: $(pwd)/$OUTPUT_FILE"
    echo "文件大小: $FILE_SIZE"
else
    echo -e "${RED}✗ 镜像压缩失败${NC}"
    exit 1
fi

# 第三步: 上传到 OSS 并生成临时 URL
echo -e "${YELLOW}\n[3/3] 上传到 OSS 并生成临时 URL...${NC}"

# 检查 ossutil 是否已安装
if ! command -v ossutil &> /dev/null; then
    echo -e "${RED}✗ 错误: 未找到 ossutil 命令${NC}"
    echo "请先安装 ossutil: https://help.aliyun.com/document_detail/120075.html"
    exit 1
fi

# 检查 OSS 配置文件
OSS_CONFIG_FILE="${HOME}/.ossutilconfig"
if [ ! -f "$OSS_CONFIG_FILE" ]; then
    echo -e "${RED}✗ 错误: 未找到 OSS 配置文件${NC}"
    echo "请先配置 ossutil: ossutil config"
    exit 1
fi

# 从环境变量或配置获取 OSS 相关信息
OSS_BUCKET="custom-devops"
OSS_ENDPOINT="${OSS_ENDPOINT:-}"

if [ -z "$OSS_BUCKET" ]; then
    echo -e "${RED}✗ 错误: 未设置 OSS_BUCKET 环境变量${NC}"
    echo "请设置环境变量: export OSS_BUCKET=your-bucket-name"
    exit 1
fi

# 生成 OSS 路径
OSS_KEY="gtja/$(date +%Y_%m_%d)/$OUTPUT_FILE"

echo "上传目标: oss://${OSS_BUCKET}/$OSS_KEY"

# 上传文件到 OSS
if ossutil cp "$OUTPUT_FILE" "oss://$OSS_BUCKET/$OSS_KEY" --force; then
    echo -e "${GREEN}✓ 文件上传成功${NC}"
else
    echo -e "${RED}✗ 文件上传失败${NC}"
    exit 1
fi

# 生成 24 小时的临时 URL
echo -e "${YELLOW}生成临时访问 URL...${NC}"

EXPIRATION=$((24 * 60 * 60))  # 24 小时的秒数

# 使用 ossutil sign 命令生成临时 URL
TEMP_URL=$(ossutil sign "oss://$OSS_BUCKET/$OSS_KEY" --expires-duration 24h 2>/dev/null | head -1)

if [ -n "$TEMP_URL" ]; then
    echo -e "${GREEN}✓ 临时 URL 生成成功（有效期: 24小时）${NC}"
    echo -e "${GREEN}临时访问 URL:${NC}"
    echo "$TEMP_URL"
    
    # 将 URL 保存到文件
    URL_FILE="${OUTPUT_FILE%.*}_url.txt"
    echo "$TEMP_URL" > "$URL_FILE"
    echo -e "${GREEN}URL 已保存到: $URL_FILE${NC}"
else
    echo -e "${RED}✗ 临时 URL 生成失败${NC}"
    exit 1
fi

echo -e "${GREEN}\n======== 所有操作完成！========${NC}"
echo "总结:"
echo "  ✓ 镜像已拉取: $DOCKER_URL"
echo "  ✓ 镜像已压缩: $OUTPUT_FILE ($FILE_SIZE)"
echo "  ✓ 文件已上传: oss://$OSS_BUCKET/$OSS_KEY"
echo "  ✓ 临时 URL 已生成（24小时有效）"

