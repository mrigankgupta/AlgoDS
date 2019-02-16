//
//  Queue.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 11/11/17.
//  Copyright © 2017 Gupta, Mrigank. All rights reserved.
//

import Foundation

public struct Queue<T> {
    
    private var arr = [T]()
    
    public init(){}
    public mutating func add(_ value:T) {
        arr.append(value)
    }
    
    public mutating func remove() -> T? {
        if arr.count > 0 {
            return arr.remove(at: 0)// O(n) runtime, better use linkedList
        }
        return nil
    }
    
    public func count() -> Int {
        return arr.count
    }
}

