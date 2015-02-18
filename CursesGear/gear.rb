#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#
# ltsvデータをJSONに変換
#

require 'json'
require "curses"
include Curses

#init_screen
#start_color # これがないと色が出ないorz ... アホな仕様か
#init_pair 1, COLOR_YELLOW, COLOR_BLUE
#init_pair 2, COLOR_BLACK, COLOR_WHITE
#stdscr.bkgd color_pair(1)
#stdscr.attrset color_pair(1)
#refresh
#clear
stdscr.keypad true    # up/downキーの扱い http://rb.blog.pasberth.com/post/27046375001/ruby-curses
#puts Key::UP
noecho

@nodelist = []

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

def calc # @centerNodeを中心にnodelistを計算
  @nodelist = {}
  @nodelist[0] = @centerNode
  node = @centerNode
  i = 0
  @nodelist[i+=1] = node while node = nextNode(node)
  node = @centerNode
  i = 0
  @nodelist[i-=1] = node while node = prevNode(node)

  display
end

#def expand
#  if @nodelist[0]['children']
#    calc @nodelist[0].children[0]
#    expandTimeout = setTimeout expand, StepTime

def cls
  (0...30).each { |y|
    stdscr.setpos y, 0
    stdscr.addstr "                                                     "
  }
end

def display
  cls
  @nodelist.each { |key,val|
    stdscr.setpos 12+key, 3+val['level'].to_i
    s = val['title']
    s += "-----" if key == '0'
    stdscr.addstr val['title'] + key.to_s
  }
end

def move(delta)
  if @nodelist[delta]
    @centerNode = @nodelist[delta]
    calc
  end
end

#
# 初期化
#
root = readltsv 'contents.ltsv'
initlinks root, 0

@centerNode = root['children'][0]

calc

#nodelist = calc(centerNode)

#
# メインループ
#

while true do
  c = getch
  if c == Key::UP
    move 1
  elsif c == Key::DOWN
    move -1
  end
end

