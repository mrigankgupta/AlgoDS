//: Playground - noun: a place where people can play

import UIKit
import DataStructSet

var bt = BinarySearchTree()
var root:Node<Int>?
//1,8,7,4,6,3,5,2
for i in [1,3,5,4,12,15,9,10] {
    root = bt.insertRec(root: root, value: i)
}
//bt.inorderTraversalRec(root: root)
//bt.inorderTraversal(root: root)
//bt.preorderTraversal(root: root)
//bt.height(root)
//bt.levelOrderTraversal(root: root)

//let sl = SinglyLinkedList()
//var sroot:SNode<Int>!
//for i in 1...10 {
//    sroot = sl.insert(root: sroot, value: i)
//}
//sl.print(root: sroot)

/*
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


var preOrder = ["a","b","c","d","e","f","h","i","g"]
var inOrder = ["c","b","d","a","h","f","i","e","g"]

var r = bt.buildBinaryTree(preOr: preOrder, inOr: inOrder)
bt.inorderTraversal(root: r)
bt.height(r)
*/



//print(find(root: root, value: 2))
//print(predesecessor(root: root, value: 4).0?.data,predesecessor(root: root, value: 4).1?.data)
bt.deletion(root: &root, value: 1)
bt.inorderTraversal(root: root)
bt.deletion(root: &root, value: 2)
bt.inorderTraversal(root: root)

print(DataStructSet.binarySearch(arr: [1,2,3,4,5,6,7,8], value: 1))
print(DataStructSet.binarySearchRec(arr: [1,2,3,4,5,6,7,8], value: 0))

var a = [9,1,8,7,4,6,3,5,2,10]
print(quickSort(arr: &a, start: 0, end: a.count-1))
print(a)
a = [9,1,8,7,4,6,3,5,2,10]
insertionSort(arr: &a)
print(a)
a = [9,1,8,7,4,6,3,5,2,10]
selectionSort(arr: &a)
print(a)


a = [9,1,8,7,4,6,3,5,2,10]
var c = [5,6,8,10,7,6,4,3,2]
merge(arr: &c,l:0,m:5,r:c.count-1)
print(c)
mergeSort(arr: &a, left: 0, right: a.count-1)
print(a)
var noHeap = [10,12,15,4,1,5,9,3]
buildHeap(arr: &noHeap)
noHeap = [7,1,2]
heapSort(arr: &noHeap, count: noHeap.count)
print(noHeap)
heapify(arr: &noHeap, index: 0, count:noHeap.count)

func peekFind<T>(arr:[T]) -> T? where T : Equatable & Comparable {
    var peek: T?
    if arr.count > 0 {
        var i = 0
        while i < arr.count && (peek == nil || peek! <= arr[i]) {
            peek = arr[i]
            i+=1
        }
    }
    
    return peek
}

func peekFindBinary<T>(arr:[T], l:Int, r:Int) -> T? where T : Equatable & Comparable {
    
    let index: Int = (l+r) / 2
    if arr[index] < arr[index+1] {
        return peekFindBinary(arr: arr, l: index+1, r: r)
    }else if arr[index] < arr[index-1] {
        return peekFindBinary(arr: arr, l: l, r: index-1)
    }else {
        print(arr[index])
        return arr[index]
    }
}
print(peekFind(arr: c))
var i = peekFindBinary(arr: c, l: 0, r: c.count-1)


//class NodeD<T> {
//    var data : T!
//    var left : NodeD?
//    var right: NodeD?
//    
//    init(data:T) {
//        self.data = data
//        self.left = nil
//        self.right = nil
//    }
//}
//
//
//func find<T>(root:NodeD<T>?,value:T) -> NodeD<T>? where T: Comparable & Equatable {
//    if root == nil {
//        return nil
//    }
//    if root!.data > value {
//        return find(root: root?.left, value: value)
//    }else if root!.data < value {
//        return find(root: root?.right, value: value)
//    }else if root!.data == value {
//        return root
//    }
//    return nil
//}
//
//func max<T>(root:NodeD<T>?) -> NodeD<T>? where T: Comparable & Equatable {
//    if root == nil {
//        return nil
//    }
//    var next = root
//    var prev : NodeD<T>?
//    while next != nil {
//        prev = next
//        next = next!.right
//    }
//    return prev
//}
//
//func prede<T>(root:NodeD<T>?, value:T) -> NodeD<T>? where T: Comparable & Equatable {
//    if root == nil {
//        return nil
//    }
//    let element = find(root: root, value: value)
//    if element?.left != nil {
//        return max(root:element!.left)
//    }else {
//        var next = root
//        var lastRight: NodeD<T>?
//        while next != nil {
//            if next!.data > value {
//                next = next?.left
//            }else if next!.data < value {
//                lastRight = next
//                next = next?.right
//            }else if next!.data == value {
//                break
//            }
//        }
//        return lastRight
//    }
//}
//
//func build<T>(root:NodeD<T>?, value:T) -> NodeD<T> where T: Comparable & Equatable {
//    let node = NodeD(data: value)
//    if root == nil {
//        return node
//    }
//    var next = root
//    var prev : NodeD<T>?
//    while next != nil {
//        if next!.data > value {
//            prev = next
//            next = next?.left
//        }else if next!.data < value {
//            prev = next
//            next = next?.right
//        }
//    }
//    if prev!.data > value {
//        prev?.left = node
//    }else {
//        prev?.right = node
//    }
//    return root!
//}
//
//func inorder<T>(root:NodeD<T>?) {
//    if root == nil {
//        return
//    }
//    inorder(root: root!.left)
//    print(root!.data)
//    inorder(root: root!.right)
//}
//print("hi")
//let arr = [20, 9, 8, 10, 13, 16, 29, 4, 12]
//var rr : NodeD<Int>?
//for item in arr {
//    rr = build(root: rr, value: item)
//}
//
//inorder(root: rr)
//find(root: rr, value: 4)?.data
//max(root: rr)?.data
//
//prede(root: rr, value: 12)?.data

//Q1


func removeDupOSpace<T>(root:DNode<T>?) -> [T:Bool]? where T : Equatable & Comparable {
    if root == nil {
        return nil
    }
    var dict = [T:Bool]()
    
    var current = root
    while current != nil {
        if dict[current!.data] == nil {
            dict[current!.data] = true
        }
        current = current?.next
    }
    return dict
}

var rootT: DNode<Int>? = nil
var dlist = DoubleLinkedList()
for i in [10,1,2,1,3,4,5,4,6,7,5,3,4,1,5,8] {
    rootT = dlist.buildLinkedList(root: rootT , data: i)
}

dlist.traverse(root: rootT)
//removeDupOSpace(root: rootT)

func removeDup<T>(root:DNode<T>?) -> DNode<T>? where T: Equatable & Comparable {
    if root == nil {
        return nil
    }
    var current = root
    var look = current?.prev
    var prev = current?.prev
    while current != nil {
        while look != nil {
            if current!.data != look!.data {
                look = look?.prev
            }else{
                //remove current
                if current?.next != nil {
                    prev?.next =  current?.next
                    current?.next?.prev = prev
                }else{
                    prev?.next = nil
                }
                current = prev
                break
            }
        }
        look = current
        prev = current
        current = current?.next
    }
    return root
}
rootT = removeDup(root: rootT)
print(dlist.traverse(root: rootT))

//Q2

func kthToLastElement<T>(root:DNode<T>?, kth:Int) -> T? {
    if root == nil {
        return nil
    }
    
    var i = 0
    var runner = root
    while i <= kth &&  runner != nil {
        runner = runner?.next
        i = i + 1
    }
    var current = root
    while runner != nil {
        current = current?.next
        runner = runner?.next
    }
    return current?.data
}

print(kthToLastElement(root: rootT, kth: 3))

//Q3

func deleteMiddle<T>(root:SNode<T>?) -> SNode<T>? {
    if root == nil {
        return nil
    }
    var runner = root
    var current = root
    var prev:SNode<T>?
    var counter = 0
    while runner != nil {
        runner = runner?.next
        counter = counter + 1
        if counter % 2 == 0 {
            prev = current
            current = current?.next
        }
    }
    //remove middle
    prev?.next = current?.next
    
    return root
}

var slist = SinglyLinkedList()
var sRoot: SNode<Int>?
for i in [1,2,3,4,5,6,7,8,9] {
    sRoot = slist.insert(root: sRoot, value: i)
}
sRoot = deleteMiddle(root: sRoot)
print(slist.print(root: sRoot))


//Q4
//TODO
func partition<T>(root:DNode<T>?, pivot:T) -> DNode<T>? where T: Equatable & Comparable {
    if root == nil {
        return nil
    }
    var length = 0
    var current = root
    var prev : DNode<T>?
    while current != nil {
        length = length + 1
        prev = current
        current = current?.next
    }
    var last = prev
    var start = root
    var prevToStart:DNode<T>?
    var nextToLast:DNode<T>?
    var i = 0
    var j = length
    while i < j {
        if last!.data >= pivot {
            nextToLast = last
            last = last?.prev
            j = j - 1
        }else if start!.data < pivot {
            prevToStart = start
            start = start?.next
            i = i + 1
        }else {
            print(start?.data)
            print(last?.data)
            //swap
            let nextOfStart = start?.next
            let prevOfLast = last?.prev
            
            prevToStart?.next = last
            nextOfStart?.prev = last
            last?.next = nextOfStart
            last?.prev = prevToStart
            
            start?.next = nextToLast
            start?.prev = prevOfLast
            nextToLast?.prev = start
            prevOfLast?.next = start
            
            start = nextOfStart
            i = i + 1
            last = prevOfLast
            j = j - 1
            print(nextOfStart?.data)
            print(prevOfLast?.data)

        }
    }
    return root
}


func partitionOSpace<T>(root:SNode<T>?, pivot:T) -> SNode<T>?
    where T: Equatable & Comparable {
        if root == nil {
            return nil
        }
        var current = root
        var bList:SNode<T>?
        var sList:SNode<T>?
        var sHead:SNode<T>?
        var bHead:SNode<T>?

        while current != nil {
            if current!.data < pivot {
                if sHead == nil {
                    sHead = current
                    sList = current
                }else{
                    sList!.next = current
                    sList = current
                }
            }else{
                if bHead == nil {
                    bHead = current
                    bList = current
                }else{
                    bList!.next = current
                    bList = current
                }
            }
            current = current?.next
        }
        //merge
        sList?.next = bHead
        bList?.next = nil
        return sHead
}
//3 -> 5 -> 8 -> 5 -> 10 -> 2 -> 1
slist = SinglyLinkedList()
var sroot:SNode<Int>?
for i in [3,5,8,5,10,2,1] {
    sroot = slist.insert(root: sroot, value: i)
}
sroot = partitionOSpace(root: sroot, pivot: 5)
slist.print(root: sroot)
//Q6
func isPalindromeOSpace<T>(root:SNode<T>?) -> Bool where T: Hashable {
    if root == nil {
        return false
    }
    var dict = [T:Int]()
    
    var current = root
    while current != nil {
        if let count = dict[current!.data] {
            dict[current!.data] = count + 1
        }else{
            dict[current!.data] = 1
        }
        current = current?.next
    }
    var odd = 0
    for (_,val) in dict {
        if val%2 == 1 {
            odd = odd + 1
        }
        if odd > 1 {
            return false
        }
    }
    return true
}

func isPalindromeBitwise(root:SNode<Character>?) -> Bool {
    var count = 0
    var current = root
    while current != nil {
        let ascii = current!.data.ascii()
        let masked = ascii & 31
        print(masked)
        let bit = 1 << masked
        count = count ^ bit
        current = current?.next
    }
    //count it
    print(count)
    var odd = 0
    var bitCheck = 1
    while bitCheck > 0 {
        let result = count & bitCheck
        if result > 0 {
            odd = odd + 1
        }
        if odd > 1 {
            return false
        }
        bitCheck = bitCheck << 1
    }
    return true
}


var cList = SinglyLinkedList()
var cRoot: SNode<Character>?
var cArray:[Character] = ["a","b","c","c","a","b","d","c","c"]
for ch in cArray {
    cRoot = cList.insert(root: cRoot, value: ch)
}
isPalindromeOSpace(root: cRoot)
isPalindromeBitwise(root: cRoot)

//Q7

func isIntersecting<T>(root1:SNode<T>?, root2:SNode<T>?) -> SNode<T>? {
    if root1 == nil || root2 == nil {
        return nil
    }
    //get length
    var l1 = 0
    var c1 = root1
    while c1 != nil {
        l1 = l1 + 1
        c1 = c1?.next
    }
    
    var l2 = 0
    var c2 = root2
    while c2 != nil {
        l2 = l2 + 1
        c2 = c2?.next
    }
    let diff = l1 - l2
    var big = root1
    var small = root2
    if diff <= 0 {
        big = root2
        small = root1
    }
    var distance = abs(diff)
    while distance > 0 {
        big = big?.next
        distance = distance - 1
    }
    while big != nil && small != nil {
        if small !== big {
            big = big?.next
            small = small?.next
        }else {
            return small
        }
    }
    return nil
}
var r1 = SNode(data:1)
var r2 = SNode(data:3)
var intersect:SNode<Int>!
var nr1 = r1
var nr2 = r2

for i in [2,3,4,5,6,7,8,9,10] {
    nr1.next = SNode(data:i)
    nr1 = nr1.next!
    if i >= 4  && i < 6 {
        nr2.next = SNode(data:i)
        nr2 = nr2.next!
    }else if i == 6 {
        nr2.next = nr1
    }
}
slist.print(root: r1)
slist.print(root: r2)

print(isIntersecting(root1: r1, root2: r2)?.data)

//Q8

func loopDetection<T>(root:SNode<T>?) -> SNode<T>? {
    if root == nil {
        return nil
    }
    var current = root
    var runner = root
    while current != nil && runner != nil  {
        current = current?.next
        if runner?.next != nil {
            runner = runner?.next?.next
        }
        if current === runner {
            return current
        }
    }
    return nil
}

var lRoot: SNode<Int> = SNode(data: 0)
var loopNode:SNode<Int>!
var next:SNode<Int>? = lRoot
for i in [1,2,3,4,5,6,7,8] {
    next?.next = SNode(data: i)
    if i == 4 {
        loopNode = next?.next
    }else if i == 8 {
        next?.next = loopNode
    }
    next = next?.next
}

print(loopDetection(root: lRoot)?.data)

//Q5

func listSum(root1:SNode<Int>?, root2:SNode<Int>?) -> SNode<Int>? {
   
    var c1 = root1
    var c2 = root2
    var s: SNode<Int>?
    var next: SNode<Int>?
    var carry: Int = 0
    var sum = 0
    var digit = 0
    while c1 != nil && c2 != nil {
        
        sum = c1!.data + c2!.data + carry
        digit = sum % 10
        carry = sum / 10
        if s == nil {
            s = SNode(data: digit)
            next = s
        }else{
            next?.next = SNode(data: digit)
            next = next?.next
        }
        
        c1 = c1?.next
        c2 = c2?.next
    }
    while c1 == nil &&  c2 != nil {
        sum = c2!.data + carry
        digit = sum % 10
        carry = sum / 10
        next?.next = SNode(data: digit)
        next = next?.next
        c2 = c2?.next
    }
    while c2 == nil &&  c1 != nil {
        sum = c1!.data + carry
        digit = sum % 10
        carry = sum / 10
        next?.next = SNode(data: digit)
        next = next?.next
        c1 = c1?.next
    }
    return s
}

var digit1: SNode<Int>?
for i in [7,1,6] {
    digit1 = slist.insert(root: digit1, value: i)
}

var digit2: SNode<Int>?
for i in [5,1] {
    digit2 = slist.insert(root: digit2, value: i)
}

slist.print(root: listSum(root1: digit1, root2: digit2))










