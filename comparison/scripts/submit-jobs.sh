#!/bin/bash

# 引数がない場合はエラーメッセージを表示して終了
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# 指定されたディレクトリ
TARGET_DIR="$1"

# ディレクトリが存在するか確認
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' does not exist."
    exit 1
fi

# find で .sh ファイルを探し、xargs で1つずつ sbatch に渡す
find "$TARGET_DIR" -type f -name "*.sh" | xargs -n 1 sbatch
