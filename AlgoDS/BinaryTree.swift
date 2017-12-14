//
//  BinaryTree.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 18/11/17.
//  Copyright © 2017 Gupta, Mrigank. All rights reserved.
//

import Foundation

public class Node<T>{
    
    public var data: T
    public var left:Node?
    public var right:Node?
    public init(data:T) {
        self.data = data
    }
}

public class BinaryTree {
    
    public init() {}
    public func inorderTraversalRec<T>(root:Node<T>?) {
        if root == nil {
            return
        }
        inorderTraversalRec(root: root?.left)
        print(root!.data)
        inorderTraversalRec(root: root?.right)
    }
    
    public func inorderTraversal<T>(root:Node<T>?) {
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
    
    public func preorderTraversal<T>(root:Node<T>?) {
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
    
    public func height<T>(_ root:Node<T>?) -> Int {
        return treeHeightRec(root,0)
    }
    
    public func treeHeightRec<T>(_ root:Node<T>?,_ h: Int) -> Int {
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
    
    public func levelOrderTraversal<T>(root:Node<T>?) {
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
    public func buildBinaryTree<T>(preOr:[T], inOr:[T]) -> Node<T>? where T: Equatable{
        if preOr.count == 0 || inOr.count == 0
            || preOr.count != inOr.count {
            return nil
        }
        let r = preOr[0]
        let root = Node(data:r)
        let split = inOr.split {$0 == r}
        if split.count > 1 {
            let inOrL = Array(split[0])
            let inOrR = Array(split[1])
            let preOrL = Array(preOr[1...inOrL.count])
            let preOrR = Array(preOr[(preOrL.count+1)...])
            root.right = buildBinaryTree(preOr: preOrR, inOr: inOrR)
            root.left = buildBinaryTree(preOr: preOrL, inOr: inOrL)
        }
        return root
    }
}

public class BinarySearchTree: BinaryTree {
    public func insert<T:Comparable>(root:Node<T>?, value:T) -> Node<T>?  {
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
    
    public func insertRec<T:Comparable>(root:Node<T>?, value:T) -> Node<T>?  {
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
}

