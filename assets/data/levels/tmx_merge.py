#! /usr/bin/env python
# -*- coding: utf-8 -*-

import xml.dom.minidom

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
		self.layers = []

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
		for child in node.childNodes:
			if child.nodeType == node.ELEMENT_NODE:
				if child.tagName == "data":
					# dataノード解析
					self.parseLayerData(child)

	def parseLayerData(self, node):
		# layer.dataを解析
		# TODO: 単一レイヤーのみ対応
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
		# layerを追加
		self.layers.append(layer)

	def dump(self):
		print "TmxLoader: (width,height)=(%d,%d)"%(self.width, self.height)
		for layer in self.layers:
			layer.dump()

def main():
	tmx = TmxLoader("001.tmx")
	tmx.dump()

if __name__ == '__main__':
	main()

