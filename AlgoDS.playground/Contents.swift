//: Playground - noun: a place where people can play

import UIKit
//import DataStructSet
/*
var bt = BinarySearchTree()
var root:Node<Int>?
//1,8,7,4,6,3,5,2
for i in [1,8,7,4,6,3,5,2] {
    root = bt.insertRec(root: root, value: i)
}
//bt.inorderTraversalRec(root: root)
//bt.inorderTraversal(root: root)
//bt.preorderTraversal(root: root)
//bt.height(root)
bt.levelOrderTraversal(root: root)

func binarySearch(arr:[Int], value:Int) -> Int? {
    var l = 0
    var r = arr.count-1
    var m:Int!
    var mv:Int!
    while l <= r {
        m = (l+r)/2
        mv = arr[m]
        if mv == value {
            return m
        }else if value > mv {
            l = m+1
        }else {
            r = m-1
        }
    }
    return nil
}

print(binarySearch(arr: [1,2,3,4,5,6,7,8], value: 1))

func binarySearchRec(arr:[Int], value:Int) -> Int? {
   return bs(arr: arr, l: 0, r: arr.count-1, v: value)
}

func bs(arr:[Int], l:Int, r:Int, v:Int) -> Int? {
    if l > r {
        return nil
    }
    let m:Int = (l+r)/2
    let mv:Int = arr[m]
    if v == mv {
        return m
    }else if v > mv {
       return bs(arr: arr, l:m+1, r:r , v: v)
    }else {
        return bs(arr: arr, l:l, r:m-1, v: v)
    }
}
print(binarySearchRec(arr: [1,2,3,4,5,6,7,8], value: 0))
*/
// Hashing
// Linear Probing

public class SNode<T> {
    public
    var data:T
    var next:SNode<T>?
    init(data:T) {
        self.data = data
    }
}

public class SinglyLinkedList {
    
    func insert<T>(root:SNode<T>?, value:T) -> SNode<T>? {
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
    
    func print<T>(root:SNode<T>?) {
        if root == nil {
            return
        }
        Swift.print(root!.data)
        print(root: root!.next)
    }
}

let sl = SinglyLinkedList()
var sroot:SNode<Int>!
for i in 1...10 {
    sroot = sl.insert(root: sroot, value: i)
}
sl.print(root: sroot)


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
    
    func remove(key:T.Key) {
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

struct Dict <key: Hashable,value> : KeyValue {
    var k: key
    var v: value
    typealias Key = key
    typealias Value = value
}
var ht = HashTable<Dict<String, Int>>(count: 10)

ht.update(value: Dict(k:"I", v: 1))
ht.update(value: Dict(k:"am", v: 2))
ht.update(value: Dict(k:"programmer", v: 3))
ht.update(value: Dict(k:"artist", v: 4))
ht.update(value: Dict(k:"swift", v: 7))
ht.update(value: Dict(k:"mrigank", v: 8))
ht.update(value: Dict(k:"java", v: 5))
ht.update(value: Dict(k:"c++", v: 6))
ht.update(value: Dict(k:"python", v: 7))
ht.update(value: Dict(k:"haskel", v: 11))
ht.update(value: Dict(k:"objc", v: 20))

ht.update(value: Dict(k:"mrigank", v: 9))
ht.update(value: Dict(k:"mrigank", v: 10))

print(ht.value(key: "java"))
print(ht.value(key: "swift"))
print(ht.value(key: "objc"))
print(ht.value(key: "c++"))
ht.remove(key: "c++")
print(ht.value(key: "c++"))
