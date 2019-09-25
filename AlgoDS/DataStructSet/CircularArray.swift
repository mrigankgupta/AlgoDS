//
//  CircularArray.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 09/09/18.
//  Copyright © 2018 Gupta, Mrigank. All rights reserved.
//

import Foundation

//CircularArray

public struct CircularArray<T> {
    var array: Array<T>
    var head: Int = 0

    public init() {
        self.array = Array<T>()
    }
    public func circular(index: Int) -> Int {
        return (head + index)%array.count
    }

    public func isValid(index: Int) -> Bool {
        precondition(index < 0 || index > array.count - 1, "Index out of bond")
        return true
    }

    public mutating func append(_ new: T) {
        array.append(new)
    }

    public mutating func removeLast() -> T {
        if head == array.count - 1 {
            head = head - 1
        }
        return array.removeLast()
    }

    public mutating func remove(at index: Int) -> T? {

        if isValid(index: index), index == head && index == array.count - 1 {
            head = head - 1
        }
        return array.remove(at: circular(index: index))
    }

    public mutating func rotate(shift: Int) {
        head = circular(index: shift)
    }

    public func itemAt(index: Int) -> T? {
        guard isValid(index: index) else {
            return nil
        }
        return array[circular(index: index)]
    }
}

extension CircularArray: Sequence {
    public func makeIterator() -> CircularArrayIterator<T> {
        return CircularArrayIterator()
    }
}

public struct CircularArrayIterator<T>: IteratorProtocol {

    public typealias Element = T

    var circularArray: CircularArray<T>
    var idx: Int

    public init() {
        self.circularArray = CircularArray()
        self.idx = circularArray.array.count
    }

    mutating public func next() -> T? {
        if idx > 0 {
            idx -= 1
            return circularArray.array[circularArray.circular(index: idx)]
        }else{
            return nil
        }
    }
}
