#!/bin/bash

# dotfilesのパス
DOTFILES_PATH=~/dotfiles

# nvimの設定ファイルのパス
NVIM_CONFIG_PATH=~/.config/nvim

# 現在日時を取得
NOW=$(date '+%Y%m%d%H%M%S')

# バックアップ用のサフィックス
BACKUP_SUFFIX=".bk_$NOW"

# nvimの設定ファイルのバックアップ（存在する場合）
if [ -d $NVIM_CONFIG_PATH ]; then
    echo "Backing up existing nvim config..."
    mv $NVIM_CONFIG_PATH $NVIM_CONFIG_PATH$BACKUP_SUFFIX
else
    echo "Creating nvim config directory..."
    mkdir -p $NVIM_CONFIG_PATH
fi

# nvimの設定ファイルのシンボリックリンクを作成
echo "Creating nvim config symlink..."
ln -s $DOTFILES_PATH/nvim/init.lua $NVIM_CONFIG_PATH/init.lua