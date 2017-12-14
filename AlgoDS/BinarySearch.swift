//
//  BinarySearch.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 18/11/17.
//  Copyright © 2017 Gupta, Mrigank. All rights reserved.
//

import Foundation
func binarySearch(arr:[Int], value:Int) -> Int? {
    var l = 0
    var r = arr.count-1
    var m:Int!
    var mv:Int!
    while l <= r {
        m = (l+r)/2
        mv = arr[m]
        if mv == value {
            return m
        }else if value > mv {
            l = m+1
        }else {
            r = m-1
        }
    }
    return nil
}

print(binarySearch(arr: [1,2,3,4,5,6,7,8], value: 1))

func binarySearchRec(arr:[Int], value:Int) -> Int? {
    return bs(arr: arr, l: 0, r: arr.count-1, v: value)
}

func bs(arr:[Int], l:Int, r:Int, v:Int) -> Int? {
    if l > r {
        return nil
    }
    let m:Int = (l+r)/2
    let mv:Int = arr[m]
    if v == mv {
        return m
    }else if v > mv {
        return bs(arr: arr, l:m+1, r:r , v: v)
    }else {
        return bs(arr: arr, l:l, r:m-1, v: v)
    }
}
print(binarySearchRec(arr: [1,2,3,4,5,6,7,8], value: 0))
