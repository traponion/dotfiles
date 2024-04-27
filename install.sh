#!/bin/bash

# dotfilesのパス
DOTFILES_PATH=~/dotfiles

# nvimの設定ファイルのパス
NVIM_CONFIG_PATH=~/.config/nvim

# 現在日時を取得
NOW=$(date '+%Y%m%d%H%M%S')

# バックアップ用のサフィックス
BACKUP_SUFFIX=".bk_$NOW"

# WSLかどうかを判定
if [[ "$(uname -r)" =~ "WSL" ]]; then
    if ! command -v wl-copy &> /dev/null
    then
        echo "Installing wl-clipboard..."
        sudo apt-get update
        sudo apt-get install -y wl-clipboard
    fi
fi

# Homebrew がインストールされていない場合はインストール
if ! command -v brew &> /dev/null
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Neovim がインストールされていない場合はインストール
if ! command -v nvim &> /dev/null
then
    echo "Installing Neovim..."
    brew install neovim
fi

# nvimの設定ファイルのバックアップ（存在する場合）
if [ -d $NVIM_CONFIG_PATH ]; then
    echo "Backing up existing nvim config..."
    mv $NVIM_CONFIG_PATH $NVIM_CONFIG_PATH$BACKUP_SUFFIX
fi

echo "Creating nvim config directory..."
mkdir -p $NVIM_CONFIG_PATH

# nvimの設定ファイルのシンボリックリンクを作成
echo "Creating nvim config symlink..."
ln -s $DOTFILES_PATH/nvim/init.lua $NVIM_CONFIG_PATH/init.lua

echo "Done!"