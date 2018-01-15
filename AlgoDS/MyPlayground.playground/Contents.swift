//: Playground - noun: a place where people can play

import UIKit
import DataStructSet

var bt = BinarySearchTree()
var root:Node<Int>?
//1,8,7,4,6,3,5,2
for i in [1,8,7,4,6,3,5,2,10] {
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
/*
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
*/

var a = [9,1,8,7,4,6,3,5,2,10]

func mergeSort<T>(arr:inout [T], left:Int, right:Int) where T: Equatable & Comparable {
    
    if right > left {
        let mid: Int = (left + right)/2
        mergeSort(arr: &arr, left: left, right: mid)
        mergeSort(arr: &arr, left: mid+1, right: right)
        merge(arr: &arr, l: left, m: mid, r: right)
    }
}

func merge<T>(arr:inout [T], l:Int, m:Int, r:Int) where T: Equatable & Comparable {
    var i = l
    var j = m+1
    var index = l
    var arrA = arr[l...m]
    var arrB = arr[m+1...r]
    
    while (m >= i && r >= j) {
        if arrA[i] < arrB[j] {
            arr[index] = arrA[i]
            i+=1
            index+=1
        }else{
            arr[index] = arrB[j]
            j+=1
            index+=1
        }
    }
    print(j,i)
    while j <= r {
        arr[index] = arrB[j]
        j+=1
        index+=1
    }
    while i <= m {
        arr[index] = arrA[i]
        i+=1
        index+=1
    }
 
}
var c = [5,6,8,10,7,6,4,3,2]
//merge(arr: &c,l:0,m:5,r:c.count-1)
print(c)

//mergeSort(arr: &a, left: 0, right: a.count-1)
print(a)


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


//Heap

func heapify<T>(arr:inout [T], index:Int, count:Int) where T: Comparable & Equatable {
    let left = (index+1)*2-1
    let right = (index+1)*2
    var minI = left

    if right < count {
        if arr[left] > arr[right] {
            minI = right
        }
    }else if right != count {
        return
    }

    while arr[index] > arr[minI] {
        arr.swapAt(minI, index)
        return heapify(arr: &arr, index: minI, count:count)
    }
}

var noHeap = [7,1,2]

heapify(arr: &noHeap, index: 0, count:noHeap.count)

func buildHeap<T>(arr:inout [T]) where T: Comparable & Equatable {
    for i in (0...arr.count/2).reversed() {
        heapify(arr: &arr, index: i, count:arr.count)
    }
}
noHeap = [10,12,15,4,1,5,9,3]
buildHeap(arr: &noHeap)

func heapSort<T>(arr:inout [T], count:Int) where T: Comparable & Equatable {
    var end = count-1
    while end >= 0 {
        delete(arr: &arr, count: end)
        end-=1
    }
}

func delete<T>(arr:inout [T], count:Int) -> T where T: Comparable & Equatable {
    let min = arr[0]
    arr.swapAt(0, count)
    heapify(arr: &arr, index: 0, count: count)
    return min
}
heapSort(arr: &noHeap, count: noHeap.count)
print(noHeap)
