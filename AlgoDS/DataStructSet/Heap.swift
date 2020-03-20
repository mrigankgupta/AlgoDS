//
//  Heap.swift
//  DataStructSet
//
//  Created by Gupta, Mrigank on 18/01/18.
//  Copyright © 2018 Gupta, Mrigank. All rights reserved.
//

import Foundation

/*
 Heap are complete binary tree
 If height of heap is h then
 Complete binary tree of height h has nodes pow(2, h+1) - 1
 so total nodes in heap will be pow(2, h) - 1 < n < pow(2, h+1) - 1
 n = floor(log(base2) h)
 Heap with Array
 parent = (i-1)/2
 left child = 2i+1
 right child = 2i+2
 */
// *****Heap*****//
/* Heapify procedure can be applied to a node only when left tree of node and right tree of node
 have heap property. because leaf are following heap property.
 We only apply heapify procedure 0..n/2 non-leafs, from down to top.
 heapify traces path down to tree and make all nodes follow heap property.*/
 
public func heapify<T>(arr: inout [T], index:Int) where T: Comparable {
    let left = 2*index+1
    let right = 2*index+2
    if right > arr.count - 1 {
        return
    }
    var minI = left
    
    if arr[left] > arr[right] {
        minI = right
    }
    
    if arr[index] > arr[minI] {
        arr.swapAt(minI, index)
        heapify(arr: &arr, index: minI)
    }
}


public func buildHeap<T>(arr: inout [T]) where T: Comparable {
    for i in (0...arr.count/2).reversed() {
        heapify(arr: &arr, index: i)
    }
}


public func heapSort<T>(arr: inout [T]) where T: Comparable {
    var end = arr.count-1
    while end >= 0 {
        delete(arr: &arr, count: end)
        end-=1
    }
}

@discardableResult public func delete<T>(arr: inout [T], count: Int) -> T where T: Comparable {
    let min = arr[0]
    arr.swapAt(0, count)
    heapify(arr: &arr, index: 0)
    return min
}
//REDO:insetion

public func insert<T:Comparable>(arr: inout [T], new:T) {
    arr.append(new)
    var index = arr.count - 1
    var parent = (index-1)/2
    while index > 0 && arr[parent] > arr[index] {
        arr.swapAt(parent, index)
        index = parent
        parent = (index-1)/2
    }
}

