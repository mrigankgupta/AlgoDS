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
 Complete binary tree of height h has nodes 2^(h+1) - 1
 so total nodes in heap will be 2^(h) - 1 < n < 2^(h+1) - 1
 n = floor(log(base2) h)
 Heap with Array
 parent = i/2
 left child = 2i
 right child = 2i+1
 
 */
// *****Heap*****//
//TODO:insetion
public func heapify<T>(arr:inout [T], index:Int, count:Int) where T: Comparable {
    let left = 2*(index+1)-1
    let right = 2*(index+1)
    var minI = left
    
    if right > count - 1 {
        return
    }
    if arr[left] > arr[right] {
        minI = right
    }
    
    while arr[index] > arr[minI] {
        arr.swapAt(minI, index)
        return heapify(arr: &arr, index: minI, count:count)
    }
}


public func buildHeap<T>(arr:inout [T]) where T: Comparable {
    for i in (0...arr.count/2).reversed() {
        heapify(arr: &arr, index: i, count:arr.count)
    }
}


public func heapSort<T>(arr:inout [T], count:Int) where T: Comparable {
    var end = count-1
    while end >= 0 {
        _ = delete(arr: &arr, count: end)
        end-=1
    }
}

public func delete<T>(arr:inout [T], count:Int) -> T where T: Comparable {
    let min = arr[0]
    arr.swapAt(0, count)
    heapify(arr: &arr, index: 0, count: count)
    return min
}

func insert<T:Comparable>(arr:inout [T], new:T) {
    arr.append(new)
    var index = arr.count - 1
    var parent = index/2
    while index > 0 && arr[parent] > arr[index] {
        arr.swapAt(parent, index)
        index = parent
        parent = index/2
    }
}
