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
bt.levelOrderTraversal(root: root)

let sl = SinglyLinkedList()
var sroot:SNode<Int>!
for i in 1...10 {
    sroot = sl.insert(root: sroot, value: i)
}
sl.print(root: sroot)


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


func deletion<T>(root:Node<T>?, value:T) {
    
}

func predesecessor<T>(root:Node<T>?, value:T) -> Node<T>? where T: Comparable & Equatable {
    // biggest in left side of node
    if root == nil {
        return nil
    }
    //find first left
    let firstLeft = find(root: root, value: value)?.left
    var predes: Node<T>?
    if firstLeft != nil {
        predes = firstLeft
        var nextRight = firstLeft?.right
        while nextRight != nil {
            predes = nextRight
            nextRight = nextRight?.right
        }
    }else {
        // Search the node and record last right until you
        // get the node
        var next = root
        var lastRightParent: Node<T>?
        while next != nil {
            if next!.data < value {
                lastRightParent = next
                next = next?.right
            }else if next!.data > value {
                next = next?.left
            } else if value == next!.data {
                predes = lastRightParent
                break
            }
        }
    }
    return predes
}

func find<T>(root:Node<T>?, value:T) -> Node<T>? where T: Equatable & Comparable {
    if root == nil {
        return nil
    }
    if root!.data == value {
        return root
    }else if value < root!.data {
        return find(root:root?.left, value:value)
    }else {
        return find(root:root?.right, value:value)
    }
}



print(find(root: root, value: 5)?.data)
print(predesecessor(root: root, value: 6)?.data)
