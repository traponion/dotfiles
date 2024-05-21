#!/bin/bash

# dotfilesのパス
DOTFILES_PATH=~/dotfiles

# nvimの設定ファイルのパス
NVIM_CONFIG_PATH=~/.config/nvim

# 現在日時を取得
NOW=$(date '+%Y%m%d%H%M%S')

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

# gzip がインストールされていない場合はインストール
if ! command -v gzip &> /dev/null
then
    echo "Installing gzip..."
    brew install gzip
fi

# deno がインストールされていない場合はインストール
if ! command -v deno &> /dev/null
then
    echo "Installing deno..."
    brew install deno
fi

# nvimの設定ファイルがある場合は消去
if [ -d $NVIM_CONFIG_PATH ]; then
    echo "Remove existing nvim config directory..."
    rm -rf $NVIM_CONFIG_PATH
fi

echo "Creating nvim config directory..."
mkdir -p $NVIM_CONFIG_PATH
mkdir -p $NVIM_CONFIG_PATH/lua

# nvimの設定ファイルのシンボリックリンクを作成
echo "Creating nvim config symlink..."
ln -s $DOTFILES_PATH/nvim/init.lua $NVIM_CONFIG_PATH/init.lua
ln -s $DOTFILES_PATH/nvim/lua/plugins.lua $NVIM_CONFIG_PATH/lua/plugins.lua

# .skkが存在する場合は消去
if [ -e ~/.skk ]; then
    echo "Remove existing .skk directory..."
    rm -rf ~/.skk
fi

# ~/.skkに辞書ファイルをwgetでダウンロード
echo "Downloading skk dictionary..."
mkdir -p ~/.skk
wget -O ~/.skk/SKK-JISYO.L.gz https://skk-dev.github.io/dict/SKK-JISYO.L.gz
gzip -d ~/.skk/SKK-JISYO.L.gz   

echo "Done!"