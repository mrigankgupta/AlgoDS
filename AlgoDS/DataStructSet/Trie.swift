//
//  Trie.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 24/02/18.
//  Copyright © 2018 Gupta, Mrigank. All rights reserved.
//

import Foundation
/* best use to search a word in collection, best suited data structure to store dictionary
 sort the words in lexographically
 Merit from hash table - yopu cant do prefix based search and dictionary takes a lot of space*/
public class TrieNode <T : Hashable>{
    public
    var dict: [T:TrieNode<T>]
    var end = false
    public init(end:Bool) {
        self.dict = [T:TrieNode<T>]()
        self.end = end
    }
}

public class Trie {
    public init() {}

    public func insert<T>(root:TrieNode<T>?, elements:[T]) -> TrieNode<T> {
        var head = root
        if head == nil {
            head = TrieNode(end: true)
        }
        var current = head
        for index in 0..<elements.count {
            let ch = elements[index]
            let end = index == elements.count-1
            
            if let current = current, current.dict[ch] == nil {
                current.dict[ch] = TrieNode<T>(end: end)
            }
            current = current?.dict[ch]
            current?.end = end
        }
        
        return head!
    }
    
    public func search<T>(root:TrieNode<T>?, val:[T], fullType: Bool) -> Bool {
        if root == nil {
            return false
        }
        var current = root
        for ch in val {
            current = current?.dict[ch]
            if current == nil {
                return false
            }
        }
        if fullType {
            return current!.end
        }
        return true
    }
}

