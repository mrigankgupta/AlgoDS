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

public class SinglyLinkedList {
    
    public init(){}
    
    public func insert<T>(root:SNode<T>?, value:T) -> SNode<T>? {
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
    
    public func print<T>(root:SNode<T>?) {
        if root == nil {
            return
        }
        Swift.print(root!.data)
        print(root: root!.next)
    }
}

public class DNode<T> {
    public var data: T!
    public var next: DNode?
    public var prev: DNode?
    init(data:T) {
        self.data = data
        self.next = nil
        self.prev = nil
    }
}

public class DoubleLinkedList {
    
    public init(){
    }
    public func buildLinkedList<T>(root:DNode<T>?, data:T) -> DNode<T>? {
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
    
    public func traverse<T>(root:DNode<T>?) {
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





