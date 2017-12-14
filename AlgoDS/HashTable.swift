//
//  HashTable.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 27/11/17.
//  Copyright © 2017 Gupta, Mrigank. All rights reserved.
//

import Foundation
// Hashing
// Linear Probing
// For an easy taking Hashable
// we can make itself with cool hash function later
public protocol KeyValue {
    associatedtype Key where Key : Hashable
    associatedtype Value
    var k : Key {get set}
    var v : Value {get set}
}

public class Element<T> {
    public
    var data:T
    var next:Element<T>?
    init(data:T) {
        self.data = data
        self.next = nil
    }
}


public class HashTable<T: KeyValue> {
    
    var arr:[Element<T>?]
    var alphaM:Int!
    public init(count:Int) {
        alphaM = count/3
        self.arr = [Element<T>?](repeating: nil, count: alphaM)// initializing with nil
    }
    
    public func update(value:T) {
        let hash = value.k.hashValue
        let index = compressionMap(hashCode: hash, range: alphaM)
        
        if arr[index] == nil {
            arr[index] = Element(data: value)
            return
        }
        let head = arr[index]
        var current = head
        var prev:Element<T>?
        while current != nil && current?.data.k != value.k {
            prev = current
            current = current?.next
        }
        if current == nil {
            prev?.next = Element(data: value)
        } else {
            current?.data.v = value.v
        }
    }
    
    public func value(key:T.Key) -> Any? {
        let hash = key.hashValue
        let index = compressionMap(hashCode: hash, range: alphaM)
        let head = arr[index]
        if head == nil {
            return nil
        }
        var current = head
        while current != nil && current?.data.k != key {
            current = current?.next
        }
        if current != nil {
            return current?.data.v
        }
        return nil
    }
    
    public func remove(key:T.Key) {
        let hash = key.hashValue
        let index = compressionMap(hashCode: hash, range: alphaM)
        let head = arr[index]
        if head == nil {
            return
        }
        var current = head
        var prev:Element<T>?
        while current != nil && current?.data.k != key {
            prev = current
            current = current?.next
        }
        if current != nil {
            prev?.next = current?.next
        }
    }
    
    func compressionMap(hashCode:Int, range:Int) -> Int {
        let a = 0.72820353
        let frac = a * Double(hashCode)
        let onlyFrac = frac.truncatingRemainder(dividingBy: 1.0)
        return Int(onlyFrac*Double(range))
    }
    
}

public struct Dict <key: Hashable,value> : KeyValue {
    public var k: key
    public var v: value
    public typealias Key = key
    public typealias Value = value
    public init(k:key, v:value){
        self.k = k
        self.v = v
    }
}
