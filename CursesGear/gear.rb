#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#
# ltsvデータをJSONに変換
#

require 'json'

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

def initlinks_xxx(nodes, parent, level)
  nodes.each_with_index { |node,i|
    node['level'] = level
    node['elder'] = (i > 0 ? nodes[i-1] : nil)
    node['younger'] = (i < nodes.length-1 ? nodes[i+1] : nil)
    node['parent'] = parent
    initlinks(node['children'],node,level+1) if node['children']
  }
end

def initlinks(node, level)
#  puts "-----#{node['title']}"
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
  #puts "nextnode = #{nextnode}"
  while !nextnode && node['parent'] do
    node = node['parent']
    nextnode = node['younger']
  end
  nextnode
end

def prevNode(node)
  prevnode = node['elder']
#  puts "prevnode = <#{prevnode}>"
  while !prevnode && node['parent'] do
    prevnode = node['parent']
  end
  prevnode
end

def calc(centerNode) # centerNodeを中心にnodeListを再計算して表示
#  puts "centerNOde.title = #{centerNode['title']}"
  nodelist = {} # 毎回富豪的にリストを生成
  nodelist[0] = centerNode
  node = centerNode
#  puts "----centerNode.prev = #{prevNode(node)}"

  i = 0
  while node = nextNode(node) do
    nodelist[i+=1] = node 
#    puts "i = #{i}"
  end
  node = centerNode
  i = 0
  while node = prevNode(node) do
    nodelist[i-=1] = node
#    puts "i = #{i}"
  end
  nodelist
end

root = readltsv 'contents.ltsv'
initlinks root, 0

calc(root['children'][0]).each { |key,val|
# calc(root).each { |key,val|
  puts key
  puts val['title']
}


# puts root['children'][0]['children'][0]['children'][0]['title']
