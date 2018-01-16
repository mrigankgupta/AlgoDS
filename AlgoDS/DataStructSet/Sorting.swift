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

// *****MergeSort*****//

public func mergeSort<T>(arr:inout [T], left:Int, right:Int) where T: Equatable & Comparable {
    
    if right > left {
        let mid: Int = (left + right)/2
        mergeSort(arr: &arr, left: left, right: mid)
        mergeSort(arr: &arr, left: mid+1, right: right)
        merge(arr: &arr, l: left, m: mid, r: right)
    }
}

public func merge<T>(arr:inout [T], l:Int, m:Int, r:Int) where T: Equatable & Comparable {
    var i = l
    var j = m+1
    var index = l
    var arrA = arr[l...m]
    var arrB = arr[m+1...r]
    
    while (m >= i && r >= j) {
        if arrA[i] < arrB[j] {
            arr[index] = arrA[i]
            i+=1
            index+=1
        }else{
            arr[index] = arrB[j]
            j+=1
            index+=1
        }
    }
    print(j,i)
    while j <= r {
        arr[index] = arrB[j]
        j+=1
        index+=1
    }
    while i <= m {
        arr[index] = arrA[i]
        i+=1
        index+=1
    }
}
