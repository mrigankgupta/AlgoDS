//
//  Stack.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 11/11/17.
//  Copyright © 2017 Gupta, Mrigank. All rights reserved.
//

import Foundation

//Stack
public struct Stack<T> {
    private var arr = [T]()
    public init(){}
    public mutating func push(_ value:T) {
        arr.append(value)
    }
    
    public mutating func pop() -> T? {
        return arr.popLast()//TODO: Remember removeLast() don't return nil but exception
    }
    
    public func count() -> Int {
        return arr.count
    }
    
    public func top() -> T? {
        return arr.last
    }
    
    public func empty() -> Bool {
        return arr.count <= 0
    }
}
