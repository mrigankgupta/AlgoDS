//: Playground - noun: a place where people can play

import UIKit
import DataStructSet

class Node<T>{
    var data: T
    var left:Node?
    var right:Node?
    init(data:T) {
        self.data = data
    }
}

class BinaryTree {
    
    func insert<T:Comparable>(root:Node<T>?, value:T) -> Node<T>?  {
        var current = root
        var parent:Node<T>?
        if current == nil {
            return Node(data: value)
        }
        
        while current != nil {
            parent = current
            if current!.data < value {
                current = current?.right
            } else {
                current = current?.left
            }
        }
        if parent!.data < value {
            parent?.right = Node(data: value)
        } else {
            parent?.left = Node(data: value)
        }
        return root
    }
    
    func insertRec<T:Comparable>(root:Node<T>?, value:T) -> Node<T>?  {
        let parent = root
        if root == nil {
            return Node(data: value)
        }
        if parent!.data < value {
            parent?.right = insertRec(root: root?.right, value: value)
        } else {
            parent?.left = insertRec(root: root?.left, value: value)
        }
        return root
    }
    
    func inorderTraversalRec<T>(root:Node<T>?) {
        if root == nil {
            return
        }
        inorderTraversalRec(root: root?.left)
        print(root!.data)
        inorderTraversalRec(root: root?.right)
    }
    
    func inorderTraversal<T>(root:Node<T>?) {
        if root == nil {
            return
        }
        var current = root
        var stack = Stack<Node<T>>()
        stack.push(current!)
        while current != nil || stack.count() > 0 {
            if current?.left != nil {
                current = current!.left
                stack.push(current!)
                continue
            }
            current = stack.pop()
            print(current!.data)
            if current?.right != nil {
                current = current!.right
                stack.push(current!)
            }else{
                current = nil
            }
        }
    }
    
    func preorderTraversal<T>(root:Node<T>?) {
        if root == nil {
            return
        }
        var current = root
        var stack = Stack<Node<T>>()
        stack.push(current!)
        while current != nil || stack.count() > 0 {
            if let data = current?.data {
                print(data)
            }
            if current?.left != nil {
                current = current!.left
                stack.push(current!)
                continue
            }
            current = stack.pop()
            if current?.right != nil {
                current = current!.right
                stack.push(current!)
            }else{
                current = nil
            }
        }
    }
    
    func height<T>(_ root:Node<T>?) -> Int {
        return treeHeightRec(root,0)
    }
    
    func treeHeightRec<T>(_ root:Node<T>?,_ h: Int) -> Int {
        if root == nil {
            return -1 //root has single node. height will be zero
        }
        let l = treeHeightRec(root?.left, h) + 1
        let r = treeHeightRec(root?.right, h) + 1
        if l > r {
            return l
        }else {
            return r
        }
    }
    
    func levelOrderTraversal<T>(root:Node<T>?) {
        if root == nil {
            return
        }
        var current = root
        var que = Queue<Node<T>>()
        while current != nil || que.count() > 0 {
            print(current!.data)
            if let left = current?.left {
                que.add(left)
            }
            if let right = current?.right {
                que.add(right)
            }
            current = que.remove()
        }
    }
    
}

var bt = BinaryTree()
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
