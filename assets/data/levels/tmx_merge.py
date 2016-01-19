#! /usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import xml.dom.minidom
import yaml

class Array2D:
	def __init__(self, width, height):
		self.width = width
		self.height = height
		self.data = {}
	def toIdx(self, x, y):
		return y * self.width + x
	def set(self, x, y, v):
		idx = self.toIdx(x, y)
		self.data[idx] = v
	def get(self, x, y):
		idx = self.toIdx(x, y)
		if idx not in self.data:
			# 存在しないのでデフォルト値
			return 0
		return self.data[idx]
	def dump(self):
		for j in range(self.height):
			str = ""
			for i in range(self.width):
				v = self.get(i, j)
				if i == 0:
					str += "%2d"%v
				else:
					str += ",%2d"%v
			print str

class TmxLoader:
	def __init__(self, filepath):
		if filepath != "":
			self.load(filepath)
		else:
			self.init()

	def init(self):
		# 初期化
		self.width = 0
		self.height = 0;
		self.layers = {}

	def load(self, filepath):
		# ロード
		self.init()
		dom = xml.dom.minidom.parse(filepath)
		self.parse(dom)

	def parse(self, dom):
		# 解析
		for node in dom.documentElement.childNodes:
			if node.nodeType == node.ELEMENT_NODE:
				if node.tagName == "layer":
					self.parseLayer(node)

	def parseLayer(self, node):
		# layerノードを解析
		self.width = int(node.getAttribute("width"))
		self.height = int(node.getAttribute("height"))
		name = node.getAttribute("name") # レイヤー名
		for child in node.childNodes:
			if child.nodeType == node.ELEMENT_NODE:
				if child.tagName == "data":
					# dataノード解析
					layer = self.parseLayerData(child)
					self.layers[name] = layer

	def parseLayerData(self, node):
		# layer.dataを解析
		# layer生成
		layer = Array2D(self.width, self.height)
		data = node.firstChild.data.strip()
		row = 0
		for line in data.split("\n"):
			# 行を解析
			col = 0
			for v in line.strip().split(","):
				# 列を解析
				if v == "":
					break
				layer.set(col, row, int(v))
				col += 1
			row += 1
		return layer

	def getLayer(self, name):
		return self.layers[name]

	def dump(self):
		print "TmxLoader: (width,height)=(%d,%d)"%(self.width, self.height)
		for name in self.layers.keys():
			print "[%s]"%name
			layer = self.getLayer(name)
			layer.dump()

def merge(idList):
	layers = []
	for id in idList:
		filename = "%03d.tmx"%id
		tmx = TmxLoader(filename)
		layer = tmx.getLayer("map")
		layers.append(layer)
	# 逆順にする
	layers.reverse()

	height = 0
	strData = ""
	for layer in layers:
		height += layer.height
		for j in range(layer.height):
			for i in range(layer.width):
				strData += "%d,"%layer.get(i, j)
			strData += "\n"
	strData = strData.strip()[0:-1]

	# tmxのテンプレート定義
	str = """<?xml version="1.0" encoding="UTF-8"?>
<map version="1.0" orientation="orthogonal" renderorder="right-down" width="9" height="%d" tilewidth="16" tileheight="16" nextobjectid="1">
 <tileset firstgid="1" name="tileset" tilewidth="16" tileheight="16" tilecount="64" columns="8">
  <image source="tileset.png" width="128" height="128"/>
 </tileset>
 <layer name="map" width="9" height="%d">
  <data encoding="csv">
%s
</data>
 </layer>
</map>
"""%(height, height, strData)

	return str

def usage():
	# 使い方
	print "Usage: tmx_merge.py [yaml]"

def parseYaml(filepath):
	f = open(filepath, "r")
	data = yaml.load(f)
	f.close()
	for level in data:
		tmp = level["idList"].split(",")
		idList = []
		for s in tmp:
			idList.append(int(s))
		output = level["output"]
		tmx = merge(idList)
		f = open(output, "w")
		f.write(tmx)
		f.close()
		print "%s -> %s"%(level["idList"], level["output"])

def main():
	argc = len(sys.argv)
	# 引数チェック
	if argc < 2:
		# 足りない
		usage()
		quit()

	# 設定ファイル
	config = sys.argv[1]
	parseYaml(config)

	print "Done."

if __name__ == '__main__':
	main()

