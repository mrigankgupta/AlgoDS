//
//  Heap.swift
//  DataStructSet
//
//  Created by Gupta, Mrigank on 18/01/18.
//  Copyright © 2018 Gupta, Mrigank. All rights reserved.
//

import Foundation

// *****Heap*****//

public func heapify<T>(arr:inout [T], index:Int, count:Int) where T: Comparable & Equatable {
    let left = (index+1)*2-1
    let right = (index+1)*2
    var minI = left
    
    if right < count {
        if arr[left] > arr[right] {
            minI = right
        }
    }else if right != count {
        return
    }
    
    while arr[index] > arr[minI] {
        arr.swapAt(minI, index)
        return heapify(arr: &arr, index: minI, count:count)
    }
}


public func buildHeap<T>(arr:inout [T]) where T: Comparable & Equatable {
    for i in (0...arr.count/2).reversed() {
        heapify(arr: &arr, index: i, count:arr.count)
    }
}


public func heapSort<T>(arr:inout [T], count:Int) where T: Comparable & Equatable {
    var end = count-1
    while end >= 0 {
        _ = delete(arr: &arr, count: end)
        end-=1
    }
}

public func delete<T>(arr:inout [T], count:Int) -> T where T: Comparable & Equatable {
    let min = arr[0]
    arr.swapAt(0, count)
    heapify(arr: &arr, index: 0, count: count)
    return min
}
