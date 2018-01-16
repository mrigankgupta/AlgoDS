//
//  SinglyLinkedList.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 27/11/17.
//  Copyright © 2017 Gupta, Mrigank. All rights reserved.
//

import Foundation
public class SNode<T> {
    public
    var data:T
    var next:SNode<T>?
    init(data:T) {
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


