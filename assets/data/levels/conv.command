#!/bin/sh

# 現在のディレクトリをカレントディレクトリに設定
cd `dirname $0`

# コンバート実行
python tmx_merge.py fixedlevel.yaml

# ターミナルを閉じる
killall Terminal
