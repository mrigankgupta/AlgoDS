//
//  CCIChapter3.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 15/02/18.
//  Copyright © 2018 Gupta, Mrigank. All rights reserved.
//

import Foundation

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



