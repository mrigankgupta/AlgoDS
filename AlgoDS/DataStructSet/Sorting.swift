//
//  Sorting.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 09/01/18.
//  Copyright © 2018 Gupta, Mrigank. All rights reserved.
//

import Foundation
/* does not handle duplicates */
func partition<T>(arr:inout [T], start:Int, end:Int) -> Int where T: Comparable {
    let p = arr[end]
    var s = start
    var e = end
    while s < e {
        if arr[s] < p {
            s += 1
        }else if arr[e] > p {
            e -= 1
        }else {
            arr.swapAt(s, e)
        }
    }
    return s
}

public func quickSort<T>(arr:inout [T], start:Int, end:Int) where T: Comparable {
    if start < end {
        let splitPos = partition(arr: &arr, start: start, end: end)
        quickSort(arr: &arr, start: start, end: splitPos-1)
        quickSort(arr: &arr, start: splitPos+1, end: end)
    }
}
// pick one element from start and place it in a suitable place in sorted array

public func insertionSort<T>(arr:inout [T]) where T: Comparable {
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

// Pick min one by one and arrange
public func selectionSort<T>(arr:inout [T]) where T: Comparable {
    for index in 0..<arr.count {
        let min = searchMin(arr,index,arr.count)
        if index != min {
            arr.swapAt(index, min)
        }
    }
}

func searchMin<T>(_ arr:[T], _ start:Int, _ end:Int) -> Int where T: Comparable {
    var min = start
    for i in start..<end {
        if arr[min] > arr[i] {
            min = i
        }
    }
    return min
}

// *****MergeSort*****//

public func mergeSort<T>(arr:inout [T], left:Int, right:Int) where T: Comparable {
    
    if right > left {
        let mid: Int = (left + right)/2
        mergeSort(arr: &arr, left: left, right: mid)//mergeSort(arr: &arr, left: left, right: mid-1)
        mergeSort(arr: &arr, left: mid+1, right: right)//mergeSort(arr: &arr, left: mid, right: right) what if take condition like this, it took me some time to figure out why it goes infinite loop. the second part is where mid will always remain less then right and terminate never hit
        merge(arr: &arr, left: left, mid: mid, right: right)
    }
}

public func merge<T>(arr: inout [T], left:Int, mid:Int, right:Int) where T: Comparable {
    var i = left
    var j = mid+1
    var index = left
    let arrA = arr[left...mid]
    let arrB = arr[mid+1...right]
    
    while (mid >= i && right >= j) {
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
    while j <= right {
        arr[index] = arrB[j]
        j+=1
        index+=1
    }
    while i <= mid {
        arr[index] = arrA[i]
        i+=1
        index+=1
    }
}
