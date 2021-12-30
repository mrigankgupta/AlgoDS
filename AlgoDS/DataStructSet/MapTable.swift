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


/*
Mapping the keys to HashTable is Hash function
 1. Hashcode Map - key to Integer
 2. Compression Map - Range to (0, m-1)

 Hashcode Map :-
 . Integer Cast
 . Component Sum - Anagram - map character with prime numbers
 . Polynimial accumlation:-
 If char is Ascii(A0,A1,A2,A3....An-1) then polynomial = A0 + A1*X + A3*X*X + A4*X*X*X ....AnXN-1 times

 Compression Map :- is a process of coneverting range 0..k to range 0..m
 1. Modulo (%) :-
 h(K) = K%m where k is key

 m is bad if it is pow(2, x)
 m as a prime is good but do not take close to pow(2, x), prime number gives you better distribution in compression map
 (* why because numbers are divisible by 2 or multiple of 2 but not easyly divisible by prime numbers)

 2. 0..Kmax multiply by A
 where A is 0 < A <= 1

 Algo
 . Multiply K*A
 . Take a fraction part of result
 . Now make a range 0..m-1 by multipling m
 
 h(k) = |m*((k*A)%1)|
 m can pow(2, p)

 3. MAD(Multiply, add, divide) :-
 The MAD method: h2(y) = [(ay + b) mod p] mod m
 
 where m is the size of the hash table, p is a prime number larger than N, and a and b are integers chosen at random from the interval [0, p-1], with a > 0.

https://www.cpp.edu/~ftang/courses/CS240/lectures/hashing.htm
 */

/* Old implementation */

//public protocol KeyValue {
//    associatedtype Key where Key : Hashable
//    associatedtype Value
//    var k : Key {get set}
//    var v : Value {get set}
//}
//
//public class Element<T> {
//    public
//    var data: T
//    var next: Element<T>?
//    var hash: Int
//    init(data: T, hash: Int) {
//        self.data = data
//        self.next = nil
//        self.hash = hash
//    }
//}
//
//
//public struct HashTable<T: KeyValue> {
//
//    var arr: [Element<T>?]
//    var alphaM: Int
//    public init(count:Int) {
//        alphaM = count/3
//        self.arr = [Element<T>?](repeating: nil, count: alphaM)// initializing with nil
//    }
//
//    public mutating func update(value:T) {
//        let hash = value.k.hashValue
//        let index = compressionMap(hashCode: hash, range: alphaM)
//        let new = Element(data: value, hash: hash)
//        if arr[index] == nil {
//            arr[index] = new
//            return
//        }
//        let head = arr[index]
//        var current = head
//        var prev:Element<T>?
//        while current != nil && current?.hash != hash && current?.data.k != value.k {
//            prev = current
//            current = current?.next
//        }
//        if current == nil {
//            prev?.next = new
//        } else {
//            current?.data.v = value.v
//        }
//    }
//
//    public func value(key:T.Key) -> Any? {
//        let hash = key.hashValue
//        let index = compressionMap(hashCode: hash, range: alphaM)
//        let head = arr[index]
//        if head == nil {
//            return nil
//        }
//        var current = head
//        while current != nil && current?.hash != hash && current?.data.k != key {
//            current = current?.next
//        }
//        if current != nil {
//            return current?.data.v
//        }
//        return nil
//    }
//
//    public func remove(key:T.Key) {
//        let hash = key.hashValue
//        let index = compressionMap(hashCode: hash, range: alphaM)
//        let head = arr[index]
//        if head == nil {
//            return
//        }
//        var current = head
//        var prev:Element<T>?
//        while current != nil && current?.hash != hash && current?.data.k != key {
//            prev = current
//            current = current?.next
//        }
//        if current != nil {
//            prev?.next = current?.next
//        }
//    }
//
//    func compressionMap(hashCode:Int, range:Int) -> Int {
//        let a = 0.72820353
//        let frac = a * Double(hashCode)
//        let onlyFrac = frac.truncatingRemainder(dividingBy: 1.0)
//        return Int(onlyFrac*Double(range))
//    }
//
//}
//
//public struct Dict <key: Hashable,value> : KeyValue {
//    public var k: key
//    public var v: value
//    public typealias Key = key
//    public typealias Value = value
//    public init(k:key, v:value){
//        self.k = k
//        self.v = v
//    }
//}

public class Element<T, K: Hashable> {
    public
    var data: T
    var next: Element<T, K>?
    let hash: Int // comparing hash is faster then comparing keys
    let key: K

    init(data: T, key: K, hash: Int) {
        self.data = data
        self.next = nil
        self.hash = hash
        self.key = key
    }
}


public struct MapTable<T, K: Hashable> {

    var arr: [Element<T,K>?]
    var alphaM: Int
    public init(count: Int) {
        alphaM = 3*count/4  //0.75 seems to be a good
        self.arr = [Element<T,K>?](repeating: nil, count: alphaM)// initializing with nil
    }

    public mutating func update(value: T, key: K) {
        let hash = key.hashValue
        let index = compressionMap(hashCode: hash, range: alphaM)
        if arr[index] == nil {
            arr[index] = Element(data: value, key: key, hash: hash)
            return
        }

        var current = arr[index]
        var prev: Element<T, K>?
        while current != nil && current?.hash != hash && current?.key != key {
            prev = current
            current = current?.next
        }
        if current == nil {
            prev?.next = Element(data: value, key: key, hash: hash)
        } else {
            current?.data = value
        }
    }

    public func value(key: K) -> Any? {
        let hash = key.hashValue
        let index = compressionMap(hashCode: hash, range: alphaM)
        let head = arr[index]
        if head == nil {
            return nil
        }
        var current = head
        while current != nil && current?.hash != hash && current?.key != key  {
            current = current?.next
        }
        if current != nil {
            return current?.data
        }
        return nil
    }

    public func remove(key: K) {
        let hash = key.hashValue
        let index = compressionMap(hashCode: hash, range: alphaM)
        let head = arr[index]
        if head == nil {
            return
        }
        var current = head
        var prev: Element<T, K>?
        while current != nil && current?.hash != hash && current?.key != key {
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


/* Set API */
//func remove(Element) -> Element?

//func update(with: Element) -> Element?
//An element equal to newMember if the set already contained such a member; otherwise, nil.

//func contains(Element) -> Bool

//func insert(Element) -> (inserted: Bool, memberAfterInsert: Element)
//  return (true, newMember) if newMember was not contained in the set. If an element equal to
//  newMember was already
//  contained in the set, the method returns (false, oldMember), where oldMember is the element
//  that was equal to newMember.

/* Set will be implemented like a hashmap as the element stored in Set must be a type of Hashable
 so it will be like an array of hash values of element as key and orignal element as value */

class SetElement <T: Hashable> {
    var data: T
    var hash: Int
    var next: SetElement<T>?
    
    init(data: T, hash: Int) {
        self.data = data
        self.hash = hash
    }
}


struct SetMap <Element: Hashable> {
    private var arr: [SetElement<Element>?]
    private var compressionCapacity: Int
    
    public init(capacity: Int) {
        self.compressionCapacity = 3*capacity/4
        self.arr = [SetElement<Element>?](repeating: nil, count: compressionCapacity)
    }
    
    mutating func update(with item: Element) -> Element? {
        let hash = item.hashValue
        let index =  compressionIndex(hash: hash, range: compressionCapacity)
        
        guard let head = arr[index] else {
            arr[index] = SetElement<Element>(data: item, hash: hash)
            return nil
        }
        
        var current: SetElement<Element>? = head
        var prev: SetElement<Element>?
        while current != nil && current!.hash != hash && current!.data != item {
            prev = current
            current = current?.next
        }
        
        if current == nil {
            prev?.next = SetElement<Element>(data: item, hash: hash)
            return nil
        }else {
            current?.data = item
        }
        return item
    }
    
    func compressionIndex(hash: Int, range: Int) -> Int {
        let random = 0.7947525
        let multiFrac = random*Double(hash)
        let frac = multiFrac.truncatingRemainder(dividingBy: 1.0)
        return Int(frac*Double(range))
    }
}

/*
 Set Operations
 Sets provide a suite of mathematical set operations. For example, you can efficiently test a set for membership of an element or check its intersection with another set:
 Use the contains(_:) method to test whether a set contains a specific element.
 Use the “equal to” operator (==) to test whether two sets contain the same elements.
 Use the isSubset(of:) method to test whether a set contains all the elements of another set or sequence.
 Use the isSuperset(of:) method to test whether all elements of a set are contained in another set or sequence.
 Use the isStrictSubset(of:) and isStrictSuperset(of:) methods to test whether a set is a subset or superset of, but not equal to, another set.
 Use the isDisjoint(with:) method to test whether a set has any elements in common with another set.
 You can also combine, exclude, or subtract the elements of two sets:
 Use the union(_:) method to create a new set with the elements of a set and another set or sequence.
 Use the intersection(_:) method to create a new set with only the elements common to a set and another set or sequence.
 Use the symmetricDifference(_:) method to create a new set with the elements that are in either a set or another set or sequence, but not in both.
 Use the subtracting(_:) method to create a new set with the elements of a set that are not also in another set or sequence.
 You can modify a set in place by using these methods’ mutating counterparts: formUnion(_:), formIntersection(_:), formSymmetricDifference(_:), and subtract(_:).
 Set operations are not limited to use with other sets. Instead, you can perform set operations with another set, an array, or any other sequence type.
 var primes: Set = [2, 3, 5, 7]

 // Tests whether primes is a subset of a Range<Int>
 print(primes.isSubset(of: 0..<10))
 // Prints "true"

 // Performs an intersection with an Array<Int>
 let favoriteNumbers = [5, 7, 15, 21]
 print(primes.intersection(favoriteNumbers))
 // Prints "[5, 7]"
 */

//var primes: Set = [2, 3, 5, 7]
//primes.insert(3)
//primes.remove(3)
//primes.contains(3)
struct MySet<T: Hashable> {
    var dict = [T: T]()
    
    mutating func insert(_ item: T) -> (Bool, T) {
        if let exist = dict[item] {
            return (false, exist)
        }
        dict[item] = item
        return (true, item)
    }
    
    mutating func remove(_ item: T) -> T? {
        return dict[item]
    }
    
    func contains(_ item: T) -> Bool {
        return dict[item] != nil ? true : false
    }
    
    func count() -> Int {
        return dict.count
    }
}
