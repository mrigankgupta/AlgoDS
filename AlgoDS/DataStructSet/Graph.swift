//
//  Graph.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 14/03/18.
//  Copyright © 2018 Gupta, Mrigank. All rights reserved.
//

import Foundation


/* Connected Graph - Any vertices are connected by some path
Complete Graph = Edge between all pairs of vertices
number of edge in complete graph m = n(n-1)/2
Tree - All vertices are connected and no cycle
Spanning tree of graph = is a subgraph which is a tree and contain all vertices of graph
 
 */

public struct Adjacency {
    var list: [Int]
    var visited: Bool
    public init(list: [Int], visited: Bool = false){
        self.list = list
        self.visited = visited
    }
}

public func dfsGraph(start: Int, arr: inout [Adjacency]){
    
    let current = arr[start]
    if current.visited {
        return
    }
    arr[start].visited = true
    print(start)
    for node in current.list {
        if !arr[node].visited {
            dfsGraph(start: node, arr: &arr)
        }
    }
}

public func bfsGraph(start: Int, arr: inout [Adjacency]) {
    var qu = Queue<Int>()
    qu.append(start)
    arr[start].visited = true
    while qu.count() > 0 {
        let current = qu.remove()!
        print(current)
        for node in arr[current].list {
            if !arr[node].visited {
                arr[node].visited = true
                qu.append(node)
            }
        }
    }
}



//Consider the following as an array of tuples that define the relationships along the branches of a tree.
//
//[[C,B],[F,D],[C],[F,A],[C,E],[C,F]]
//
//1. Write a simple data structure to represent a tree.
//2. Write a function that takes as input an array of tuples like those above, and returns the data structure representation of the tree.



public class MNode {

    var data: String
    var childs: [MNode]?

    init(data: String) {
        self.data = data
    }
}

public func traverseAndBuild(arr: [(String, String?)]) -> MNode? {

    var dict = [String: [MNode]]()
    var rootString: String?
    for (first, sec) in arr {
        if let secd = sec {
            if dict[first] == nil {
                var val = [MNode]()
                val.append(MNode(data: secd))
                dict[first] = val
            }else {
                var item = dict[first]!
                item.append(MNode(data: secd))
                dict[first] = item
            }
        }else {
            rootString = first
        }
    }
    var root: MNode?
    if let rootString = rootString {
        root = MNode(data: rootString)
    }else {
        return nil
    }

    var queue = Queue<MNode>()
    queue.append(root!)

    while queue.count() > 0 {
        let next = queue.remove()!
        if let childs = dict[next.data] {
            next.childs = childs
            for child in childs {
                queue.append(child)
            }
        }
    }

    return root
}

public func levelOrder(root: MNode?) {
    if root == nil {
        return
    }
    var queue = Queue<MNode>()
    queue.append(root!)
    while queue.count() > 0 {
        let next = queue.remove()!
        print(next.data)
        if let childs = next.childs {
            for child in childs {
                queue.append(child)
            }
        }
    }
}

//let mroot = traverseAndBuild(arr: [("C","B"),("F","D"),("C",nil),("F","A"),("C","E"),("C","F")])
//levelOrder(root: mroot)
