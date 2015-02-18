#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#
# ltsvデータをJSONに変換
#

require 'json'
require "curses"
include Curses

init_screen
#start_color # これがないと色が出ないorz ... アホな仕様か
#init_pair 1, COLOR_YELLOW, COLOR_BLUE
#init_pair 2, COLOR_BLACK, COLOR_WHITE
#stdscr.bkgd color_pair(1)
#stdscr.attrset color_pair(1)
#refresh
#clear
noecho

def readltsv(file)
  root = { 'title' => '全コンテンツ' }
  parents = [root]
  
  File.open(file){ |f|
    f.each { |line|
      line.chomp!
      next if line =~ /^\s*$/m || line =~ /^#/m
      line.sub!(/^(\s*)/,'')
      indent = $&.length
      
      node = {}
      parents[indent+1] = node
      parents[indent]['children'] = [] unless parents[indent]['children']
      parents[indent]['children'] << node
      line.split(/\t/).each { |entry|
        entry =~ /^([a-zA-Z_]+):(\s*)(.*)$/
        node[$1] = $3
      }
    }
  }
  root
end

def initlinks(node, level)
  children = node['children']
  children.each_with_index { |childnode,i|
    childnode['level'] = level+1
    childnode['elder'] = (i > 0 ? children[i-1] : nil)
    childnode['younger'] = (i < children.length-1 ? children[i+1] : nil)
    childnode['parent'] = node
    initlinks(childnode, level+1) if childnode['children']
  }
end

def nextNode(node)
  nextnode = node['younger']
  while !nextnode && node['parent'] do
    node = node['parent']
    nextnode = node['younger']
  end
  nextnode
end

def prevNode(node)
  prevnode = node['elder']
  while !prevnode && node['parent'] do
    prevnode = node['parent']
  end
  prevnode
end

def calc(centerNode) # centerNodeを中心にnodeListを計算
  nodelist = {}
  nodelist[0] = centerNode
  node = centerNode
  i = 0
  nodelist[i+=1] = node while node = nextNode(node)
  node = centerNode
  i = 0
  nodelist[i-=1] = node while node = prevNode(node)
  nodelist
end

root = readltsv 'contents.ltsv'
initlinks root, 0

#
# メインループ
#

centernode = root['children'][0]

while true do
  calc(centernode).each { |key,val|
    stdscr.setpos 12+key, 3+val['level'].to_i
    stdscr.addstr val['title']
  }
  c = getch
  puts c
end


calc(root['children'][0]).each { |key,val|
  puts key
  puts val['title']
}
# puts root['children'][0]['children'][0]['children'][0]['title']
