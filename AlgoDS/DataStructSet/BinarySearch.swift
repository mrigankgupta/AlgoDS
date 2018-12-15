//
//  BinarySearch.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 18/11/17.
//  Copyright © 2017 Gupta, Mrigank. All rights reserved.
//

import Foundation

public func binarySearch(arr:[Int], value:Int) -> Int? {
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


public func binarySearchRec(arr:[Int], value:Int) -> Int? {
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

// first common ansestor in BST
func firstCommonAncestorBST<T:Comparable>(root:Node<T>?, item1:T, item2:T) -> Node<T>? {
    if root == nil {
        return nil
    }else if (root!.data < item1 && root!.data > item2) || (root!.data < item1 && root!.data > item2) {
        return root//in the middle
    }else if root!.data < item1 && root!.data < item2 {
        return firstCommonAncestorBST(root: root?.left, item1: item1, item2: item2)
    }else {
        return firstCommonAncestorBST(root: root?.right, item1: item1, item2: item2)
    }
}
