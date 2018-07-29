//
//  Trie.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 24/02/18.
//  Copyright © 2018 Gupta, Mrigank. All rights reserved.
//

import Foundation

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
    public init() {
        
    }
    public func insert<T>(root:TrieNode<T>?, elements:[T]) -> TrieNode<T> {
        var newRoot = root
        if newRoot == nil {
            newRoot = TrieNode(end: true)
        }
        var prev: TrieNode<T>?
        var current = newRoot
        for index in 0..<elements.count {
            let ch = elements[index]
            while current != nil {
                prev = current
                current = current?.dict[ch]
            }
            
            if index < elements.count-1 {
                prev!.dict[ch] = TrieNode(end: false)
                
            }else{
                prev!.dict[ch] = TrieNode(end: true)
            }
        }
        
        return newRoot!
    }
    
    public func search<T>(root:TrieNode<T>?,val:[T], fullType:Bool) -> Bool {
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

