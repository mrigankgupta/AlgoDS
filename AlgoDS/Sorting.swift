//
//  Sorting.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 09/01/18.
//  Copyright © 2018 Gupta, Mrigank. All rights reserved.
//

import Foundation

func partion<T>(arr:inout [T], start:Int, end:Int) -> Int where T: Equatable & Comparable {
    let p = arr[end]
    var s = start
    var e = end
    while s < e {
        if arr[s] <= p {
            s += 1
        }else if arr[e] > p {
            e -= 1
        }else {
            arr.swapAt(s, e)
        }
    }
    return s
}

public func quickSort<T>(arr:inout [T], start:Int, end:Int) where T: Equatable & Comparable {
    if start < end {
        let splitPos = partion(arr: &arr, start: start, end: end)
        quickSort(arr: &arr, start: start, end: splitPos-1)
        quickSort(arr: &arr, start: splitPos, end: end)
    }
}


public func insertionSort<T>(arr:inout [T]) where T: Equatable & Comparable {
    for index in 1..<arr.count {
        var inner = 0
        while inner < index {
            if arr[inner] > arr[index] {
                arr.swapAt(inner, index)
            }
            inner += 1
        }
    }
}


public func selectionSort<T>(arr:inout [T]) where T: Equatable & Comparable {
    for index in 0..<arr.count {
        let min = searchMin(arr,index,arr.count)
        if index != min {
            arr.swapAt(index, min)
        }
    }
}

func searchMin<T>(_ arr:[T], _ start:Int, _ end:Int) -> Int where T: Equatable & Comparable {
    var min = start
    for i in start..<end {
        if arr[min] > arr[i] {
            min = i
        }
    }
    return min
}

