//
//  LRUCache.swift
//  DataStructSet
//
//  Created by Gupta, Mrigank on 06/07/18.
//  Copyright © 2018 Gupta, Mrigank. All rights reserved.
//

import Foundation

public class Cache <T> {
    var prev: SNode<T>?
    var data: Any
    public init(data: Any) {
        self.data = data
    }
}

public class LRUCache<T: Hashable> {
    var dict = [T: Cache<T>]()
    var root: SNode<T>?
    var count: Int = 0
    var lastKey: T?
    let fixed = 10
    
    public init(){}
    
    public func head() -> T? {
        return root?.data
    }
    public func insert(key: T, value: Any) {
        if root == nil {
            root = SNode<T>(data: key)
            dict[key] = Cache(data: value)
            count = 1
            lastKey = key
        }else {
            if count > fixed {
                //remove the last
                let last = dict[lastKey!]
                let secondLast = last?.prev
                secondLast?.next = nil
                dict.removeValue(forKey: lastKey!)
                lastKey = secondLast?.data
            }
            // add new and make head
            let new = SNode<T>(data: key)
            dict[key] = Cache(data: value)
            new.next = root
            //update the root's dict
            let rkey = root?.data
            let rcache = dict[rkey!]
            rcache?.prev = new
            root = new
            count += 1
        }
    }
    
    
    public func search(key: T) -> Cache<T>? {
        let found = dict[key]
        if  found != nil {
            //find in linked list, remove from the position and make it as head
            let prev = found!.prev
            let current = prev?.next
            let nxt = current?.next
            //check if it last, if it is, update lastKey also
            if key == lastKey {
                lastKey = prev?.data
            }
            prev?.next = nxt
            current?.next = root
            root = current
        }
        return found
    }
}
