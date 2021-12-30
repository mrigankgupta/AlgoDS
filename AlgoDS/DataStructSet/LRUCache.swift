//
//  LRUCache.swift
//  DataStructSet
//
//  Created by Gupta, Mrigank on 06/07/18.
//  Copyright © 2018 Gupta, Mrigank. All rights reserved.
//

import Foundation
/*
 A cache LRU (Least Recently Used) is similar to a dictionary. It stores data associated to a key. The difference between a dictionary and a Cache is that the latter has a limited capacity. Every time we reach the capacity, the Cache deletes the least recently used element.
 */
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


/*
How deque for cellForIndexPath works
 https://medium.com/@theobendixson/interviewing-with-facebook-phone-screen-questions-part-4-a0b8f3b3bd68
 
 I am thinking more about
 
 var dict: [String: Queue]
 */


/*
Design and implement a data structure for LRU (Least Recently Used) cache. It should support the following operations: get and set.

get(key) - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return nil.

set(key, value) - Set or insert the value if the key is not already present. When the cache reaches its capacity,
it should invalidate the least recently used item before inserting the new item.

The LRU Cache will be initialized with an integer corresponding to its capacity. Capacity indicates the maximum number of unique keys it can hold at a time.

Definition of “least recently used” : An access to an item is defined as a get or a set operation of the item.
“Least recently used” item is the one with the oldest access time.

*/

class LRUCached<T> {
    var head: CacheNode<T>?
    var max: Int = 10
    var current: Int = 0
    var lastKey: String?
    var dict = [String: CacheNode<T>]()
    
    func set(key: String, val: T) {
        if head == nil {
            let new = CacheNode<T>(key, val)
            dict[key] = new
            head = new
            current = 1
        } else if let found = dict[key] {
            // update the linked list
            // find the node and remove from the list, so that it can be latest head
            let prev = found.prev
            let next = found.next
            prev?.next = next
            // this will new head
            found.next = head
        } else {
            if current >= max {
                //remove the last node
                let last = dict[lastKey!]
                let secondlast = last?.prev
                secondlast?.next = nil
                lastKey = secondlast?.key
            } else {
                // add node and update the list
                let new = CacheNode<T>(key, val)
                dict[key] = new
                current += 1
                new.next = head
                head = new
            }
            
        }
    }
    
    func get(key: String) -> T? {
        let found = dict[key]
        if found != nil {
            // update the order of linkedlist
            // find the node and remove from the list
            let prev = found?.prev
            let next = found?.next
            prev?.next = next
            // this will new head
            found?.next = head
            return found?.val
        }
        return nil
    }
}

class CacheNode<T> {
    var next: CacheNode?
    var prev: CacheNode?
    var val: T
    var key: String?
    
    init(_ key: String, _ val: T) {
        self.val = val
        self.key = key
    }
}
