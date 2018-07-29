//
//  SinglyLinkedList.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 27/11/17.
//  Copyright © 2017 Gupta, Mrigank. All rights reserved.
//

import Foundation
public class SNode<T> {
    
    public var data:T
    public var next:SNode<T>?
    public init(data:T) {
        self.data = data
    }
}

public class SinglyLinkedList<T> {
    public var head: SNode<T>?
    public init(){}
    
    public func insert(root:SNode<T>?, value:T) -> SNode<T>? {
        var current = root
        let new = SNode(data: value)
        
        if root == nil {
            return new
        }
        var prev:SNode<T>!
        while current != nil {
            prev = current
            current = current?.next
        }
        prev.next = new
        return root
    }
    
    public func print(root:SNode<T>?) {
        if root == nil {
            return
        }
        Swift.print(root!.data)
        print(root: root!.next)
    }
}

extension SinglyLinkedList: Sequence {
    
    public func makeIterator() -> SinglyLinkedListIterator<T> {
        return SinglyLinkedListIterator(root: self.head)
    }
}

public struct SinglyLinkedListIterator<T> : IteratorProtocol {
    
    public typealias Element = T
    
    var current: SNode<T>?
    
    init(root: SNode<T>?) {
        self.current = root
    }
    
    mutating public func next() -> T? {
        if current == nil {
            return nil
        }
        let data = current?.data
        current = current?.next
        return data
    }
}

public class DNode<T> {
    public var data: T!
    public var next: DNode?
    public var prev: DNode?
    public init(data:T) {
        self.data = data
        self.next = nil
        self.prev = nil
    }
}

public class DoubleLinkedList<T> {
    
    public init(){
    }
    public func buildLinkedList(root:DNode<T>?, data:T) -> DNode<T>? {
        if root == nil {
            return DNode(data: data)
        }
        var current = root
        var prev: DNode<T>?
        while current != nil {
            prev = current
            current = current!.next
        }
        let new = DNode(data:data)
        prev?.next = new
        new.prev = prev
        return root
    }
    
    public func traverse(root:DNode<T>?) {
        if root == nil {
            return
        }
        var current = root
        while current != nil {
            print(current!.data, separator: " ", terminator: " ")
            current = current?.next
        }
        print("")
    }
}

