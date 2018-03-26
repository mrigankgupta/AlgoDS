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
    var list:[Int]
    var visited:Bool
    public init(list:[Int],visited:Bool){
        self.list = list
        self.visited = visited
    }
}

public func dfsGraph(start:Int, arr:inout [Adjacency]){
    
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

public func bfsGraph(start:Int, arr:inout [Adjacency]) {
    var qu = Queue<Int>()
    qu.add(start)
    arr[start].visited = true
    while qu.count() > 0 {
        let current = qu.remove()!
        print(current)
        for node in arr[current].list {
            if !arr[node].visited {
                arr[node].visited = true
                qu.add(node)
            }
        }
    }
}

