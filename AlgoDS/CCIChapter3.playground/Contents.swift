//
//  CCIChapter3.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 15/02/18.
//  Copyright © 2018 Gupta, Mrigank. All rights reserved.
//

import Foundation
import DataStructSet

//Q1
struct Stack3in1<T> {
    
    var arr = [T?]()
    var i = -3
    var j = -2
    var k = -1
    
    mutating func push(_ newElement:T, stack:Int) {
        for _ in arr.count...arr.count+3 {
            arr.append(nil)
        }
        if stack == 0 {
            i = i + 3
            arr[i] = newElement
        }else if stack == 1 {
            j = j + 3
            arr[j] = newElement
        }else{
            k = k + 3
            arr[k] = newElement
        }
    }
    
    mutating func pop(stack:Int) -> T? {
        var temp:T?
        if stack == 0 {
            temp = arr[i]
            arr[i] = nil
            if arr[i+1] == nil && arr[i+2] == nil {
                arr.removeLast(3)
            }
            i = i - 3
        }else if stack == 1 {
            temp = arr[j]
            arr[j] = nil
            if arr[j-1] == nil && arr[j+1] == nil {
                arr.removeLast(3)
            }
            j = j - 3
            
        }else{
            temp = arr[k]
            arr[k] = nil
            if arr[k-1] == nil && arr[k-2] == nil {
                arr.removeLast(3)
            }
            k = k - 3
        }
        return temp
    }
}
var sThree = Stack3in1<Int>()
for i in 0...20 {
    let index = i%3
    sThree.push(i, stack: index)
}
for i in 0...20 {
    let index = i%3
    print(sThree.pop(stack: index))
}
for i in 0...20 {
    print(sThree.arr[i])
}

struct Stack3in1Space<T> {
    
    var arr = [T]()
    var i = 0
    var j = 0
    
    mutating func push(_ new:T, stack:Int) {
        if stack == 0 {
            arr.insert(new, at: i)
            i = i + 1
        }else if stack == 1 {
            arr.insert(new, at: i+j)
            j = j + 1
        }else if stack == 2 {
            arr.append(new)
        }
    }
    
    mutating func pop(stack:Int) -> T? {
        var temp: T?
        if stack == 0 {
            temp = arr.remove(at: i-1)
            i = i - 1
        }else if stack == 1 {
            temp = arr.remove(at: i+j-1)
            j = j - 1
        }else if stack == 2 {
            temp = arr.removeLast()
        }
        return temp
    }
}
var s3 = Stack3in1Space<Int>()
for i in 0...20 {
    let index = i%3
    s3.push(i, stack: index)
}
for i in 0...20 {
    print(s3.arr[i])
}
for i in 0...20 {
    let index = i%3
    print(s3.pop(stack: index))
}


//Q2
struct StackMax <T: Comparable> {
    
    var arr = [T]()
    var maxArr = [T]()
    
    mutating func push(_ newEle:T) {
        if arr.count <= 0 {
            maxArr.append(newEle)
        }else if newEle > maxArr.last! {
            maxArr.append(newEle)
        }else{
            maxArr.append(maxArr.last!)
        }
        arr.append(newEle)
    }
    
    mutating func pop() -> T? {
        var temp: T?
        if arr.count > 0 {
            temp = arr.removeLast()
            maxArr.removeLast()
        }
        return temp
    }
    
    func max() -> T? {
        if maxArr.count > 0 {
            return maxArr.last
        }
        return nil
    }
}

var sMax = StackMax<Int>()
var smpl = [1,1,4,2,3,5,10,2,3,4,5,6,11]
for i in smpl {
    sMax.push(i)
}

for _ in 0..<smpl.count {
    print(sMax.max(), separator: " ", terminator: " ")
    print(sMax.pop(), separator: " ", terminator: " ")
    print()
}


//Q3

struct StackOfPlate<T> {
    var pArr = [[T]]()
    let max = 3
    var cArr = [T]()
    
    mutating func push(_ new:T) {
        
        if cArr.count == max {
            pArr.append(cArr)
            cArr = [T]()
        }
        cArr.append(new)
    }
    
    mutating func pop() -> T? {
        var temp: T?
        if pArr.count == 0 && cArr.count == 0 {
            return nil
        }else if cArr.count == 1 {
            temp = cArr.removeLast()
            if pArr.count >= 1 {
                cArr = pArr.removeLast()
            }
        }else{
            temp = cArr.removeLast()
        }
        return temp
    }
}


var sPlate = StackOfPlate<Int>()
for i in smpl {
    sPlate.push(i)
}

for i in smpl {
    print("stacksofPlate",sPlate.pop())
}

//Q4

struct TwoStackQ<T> {
    var pushStack = Stack<T>()
    var popStack = Stack<T>()
    
    mutating func remove() -> T? {
        return popStack.pop()
    }
    
    mutating func add(_ new:T) {
        var current: T!
        while !popStack.empty() {
            current = popStack.pop()
            pushStack.push(current)
        }
        pushStack.push(new)
        while !pushStack.empty() {
            current = pushStack.pop()
            popStack.push(current)
        }
    }
    
    func empty() -> Bool {
        return popStack.empty()
    }
    
    func peek() -> T? {
        return popStack.top()
    }
}

var sq = TwoStackQ<Int>()
let sqr = [1,2,3,4,5]
for i in sqr {
    sq.add(i)
}

for _ in 0..<sqr.count {
    print(sq.remove())
}

struct TwoQueueStack<T> {
    var flipQ = Queue<T>()
    var flopQ = Queue<T>()
    
    mutating func push(_ new: T) {
        
        if flipQ.count() == 0 {
            flipQ.add(new)
            while flopQ.count() > 0 {
                let item = flopQ.remove()
                flipQ.add(item!)
            }
        } else {
            flopQ.add(new)
            while flipQ.count() > 0 {
                let item = flipQ.remove()
                flopQ.add(item!)
            }
        }
    }
    
    mutating func pop() -> T? {
        return flipQ.count() > 0 ? flipQ.remove() : flopQ.remove()
    }
    
    mutating func count() -> Int {
        return flipQ.count() > 0 ? flipQ.count() : flopQ.count()
    }
}

var tqs = TwoQueueStack<Int>()
for i in 1...9 {
    tqs.push(i)
}
for _ in 1...9 {
    print(tqs.pop())
}
//Q5
func findMin(stack:inout Stack<Int>, count:Int) -> Int? {
    if count == 0 {
        return nil
    }
    var temp = Stack<Int>()
    var min: Int?
    var i = 0
    while i < count {
        let next = stack.pop()!
        if min == nil || next < min! {
            min = next
        }
        temp.push(next)
        i = i + 1
    }
    stack.push(min!)
    while !temp.empty() {
        let rest = temp.pop()!
        if min != rest {
            stack.push(rest)
        }
    }
    return min
}

//Q6
func sortStack(stack: Stack<Int>, count:Int) -> Stack<Int>? {
    
    var copy = stack
    var i = count
    while i > 0 {
        findMin(stack: &copy, count: i)
        i = i - 1
    }
    return copy
}
var unsorted = Stack<Int>()
for i in [3,5,7,4,0,2,1,8] {
    unsorted.push(i)
}
findMin(stack: &unsorted, count: 8)
sortStack(stack: unsorted, count: 8)

func sortStackRec(stack:inout Stack<Int>, count:Int) {
    if count <= 0 {
        return
    }
    var temp = Stack<Int>()
    var min: Int?
    var i = 0
    while i < count {
        let next = stack.pop()!
        if min == nil || next < min! {
            min = next
        }
        temp.push(next)
        i = i + 1
    }
    stack.push(min!)
    while !temp.empty() {
        let rest = temp.pop()!
        if min != rest {
            stack.push(rest)
        }
    }
    sortStackRec(stack:&stack, count: count-1)
}
sortStackRec(stack:&unsorted, count: 8)

//Q7
protocol Pat {
    
}

struct Cat<T>: Pat {
    var id:T
}

struct Dog<T>: Pat {
    var id:T
}

protocol Shelterable {
    associatedtype Time where Time: Comparable
    var admissionTime: Time {get set}
}

struct Animal<T>:Shelterable {
    var admissionTime: Int
    var type: Pat
}

//struct AnyAnimal<T:Shelterable> {
//    var shelterAnim: T
//    init(shelter:T) {
//        self.shelterAnim = shelter
//    }
//}

struct Shelter <T:Shelterable> {
    var dRoot: SNode<T>?
    var cRoot: SNode<T>?
    
    func enqueue(new:T,type:Int) -> SNode<T> {
        var root = dRoot
        if type == 0 {
            root = cRoot
        }
        
        if root == nil {
            return SNode(data: new)
        }
        var current = root
        while current?.next != nil {
            current = current?.next
        }
        current?.next = SNode(data: new)
        return root!
    }
    
    mutating func dequeueAny() -> T? {
        var root = dRoot
        if dRoot != nil && cRoot != nil {
            var cat = cRoot?.data
            var dog = dRoot?.data
            if cat!.admissionTime < dog!.admissionTime {
                root = cRoot
            }
        }else if dRoot == nil && cRoot == nil {
            return nil
        }else if dRoot == nil {
            root = cRoot
        }
        let data = root?.data
        root = root?.next
        return data
    }
    
    mutating func dequeueDog() -> T? {
        if dRoot == nil {
            return nil
        }
        let data = dRoot?.data
        dRoot = dRoot?.next
        return data
    }
    
    mutating func dequeueCat() -> T? {
        if cRoot == nil {
            return nil
        }
        let data = cRoot?.data
        cRoot = cRoot?.next
        return data
    }
}
