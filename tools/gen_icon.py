#!/usr/bin/env python
# -*- coding: utf-8 -*-

# =========================================
# 使い方
# ※あらかじめImageMagickをインストールしておく必要があります
#
# 1. このスクリプトがあるフォルダ内に "src.png" を配置
# 2. src.png は 1024x1024のpngファイル
# 3. スクリプトを実行するとiconフォルダにアイコンが出力されます
# =========================================

import os
import os.path
import shutil
import yaml

# 入力ファイル名
INPUT_FILE = "src.png"

# ImageMagickのパス
# IMAGE_MAGICK = "/opt/ImageMagick/bin/convert"
IMAGE_MAGICK = "/opt/local/bin/convert"

# 出力設定 (出力ファイル名 : アイコンサイズ)
SETTINGS = """
- "AppIcon24x24@2x"     : 48
- "AppIcon27.5x27.5@2x" : 55
- "AppIcon40x40@2x"     : 80
- "AppIcon44x44@2x"     : 88
- "AppIcon86x86@2x"     : 172
- "AppIcon98x98@2x"     : 196
- "GooglePlayStore"     : 512
- "hdpi"                : 72
- "Icon-60@2x"          : 120
- "Icon-60@3x"          : 180
- "Icon-72"             : 72
- "Icon-72@2x"          : 144
- "Icon-76"             : 76
- "Icon-76@2x"          : 152
- "Icon-Small-40"       : 40
- "Icon-Small-40@2x"    : 80
- "Icon-Small-40@3x"    : 120
- "Icon-Small-50"       : 50
- "Icon-Small-50@2x"    : 100
- "Icon-Small-60@3x"    : 180
- "Icon-Small"          : 29
- "Icon-Small@2x"       : 58
- "Icon-Small@3x"       : 87
- "Icon"                : 57
- "Icon@2x"             : 114
- "iTunesArtwork"       : 512
- "iTunesArtwork@2x"    : 1024
- "ldpi"                : 36
- "mdpi"                : 48
- "xhdpi"               : 96
- "xxhdpi"              : 144
- "xxxhdpi"             : 192
"""

def getCmdResize(inFile, outFile, width, height):
	# ImageMagickのコマンド生成
	cmd = IMAGE_MAGICK
	cmd += " -filter box" # ぼかし無効
	cmd += " -resize %dx%d %s %s"%(width, height, inFile, outFile)
	return cmd

def main():

	src = INPUT_FILE # 入力ファイル
	# 出力フォルダ作成
	outDir = "icon" # 出力フォルダ
	if os.path.exists(outDir):
		# 出力フォルダが存在して入れば削除
		shutil.rmtree(outDir)
	os.mkdir(outDir)

	# 設定データ読み込み
	data = yaml.load(SETTINGS)
	for info in data:
		for k, v in info.items():
			outFile = "%s/%s.png"%(outDir, k)
			cmd = getCmdResize(src, outFile, v, v)
			print cmd
			os.system(cmd)

if __name__ == '__main__':
	main()
