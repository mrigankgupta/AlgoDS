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
    
    public func deletion<T>(root:inout Node<T>?, value:T) -> Bool where T: Comparable & Equatable {
        if root == nil {
            return false
        }
        
        let (node,parent) = findParentAndNode(with:value, root:root)
        if node == nil {
            return false
        }else if parent == nil && (node?.left == nil || node?.right == nil) {
            if node?.left != nil {
                root = node?.left
            }else{
                root = node?.right
            }
        }else if node?.left != nil && node?.right != nil {
            // find predesessor or secessor and replace
            let (predes, _) = predesecessor(root: root, value: value)
            if predes == nil {// root
                root = root?.right
            }else {
                predes?.right = node?.right
                if parent != nil {
                    if parent?.left?.data == value {
                        parent?.left = predes
                    }else{
                        parent?.right = predes
                    }
                }
            }
        }else if node?.left != nil {
            if isLeftOf(parent: parent, value: value) {
                parent?.left = node?.left
            }else{
                parent?.right = node?.left
            }
        }else if node?.right != nil {
            if isLeftOf(parent: parent, value: value) {
                parent?.left = node?.right
            }else{
                parent?.right = node?.right
            }
        }else {
            if parent?.left?.data == node?.data {
                parent?.left = nil
            }else{
                parent?.right = nil
            }
        }
        return true
    }
    
    public func isLeftOf<T>(parent:Node<T>?, value:T) -> Bool where T: Comparable & Equatable {
        if parent?.left?.data == value {
            return true
        }else{
            return false
        }
    }
    
    public func predesecessor<T>(root:Node<T>?, value:T) -> (Node<T>?, Node<T>?) where T: Comparable & Equatable {
        // biggest in left side of node
        if root == nil {
            return (nil, nil)
        }
        var (predes, parent) : (Node<T>?, Node<T>?)
        //find element node and check left
        let elementNode = find(root: root, value: value)
        if let firstLeft = elementNode?.left {
            (predes, parent) = maximum(root: firstLeft)
            //root node
            if parent == nil {
                parent = elementNode
            }
        }else {
            // Search the node and record last right until you
            // get the node
            var next = root
            var lastRightParent: Node<T>?
            var prev: Node<T>?
            while next != nil {
                if next!.data < value {
                    parent = prev
                    prev = next
                    lastRightParent = next
                    next = next?.right
                }else if next!.data > value {
                    prev = next
                    next = next?.left
                } else if value == next!.data {
                    predes = lastRightParent
                    break
                }
            }
        }
        return (predes, parent)
    }
    
    public func maximum<T>(root:Node<T>?) -> (Node<T>?, Node<T>?) where T: Equatable & Comparable {
        if root == nil {
            return (nil, nil)
        }
        var nxt = root
        var parent: Node<T>?
        var mx : Node<T>?
        while nxt != nil {
            parent = mx
            mx = nxt
            nxt = nxt!.right
        }
        return (mx, parent)
    }
    
    public func find<T>(root:Node<T>?, value:T) -> Node<T>? where T: Equatable & Comparable {
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
    
    public func findParentAndNode<T>(with value:T,root:Node<T>?) -> (Node<T>?, Node<T>?) where T: Equatable & Comparable {
        if root == nil {
            return (nil, nil)
        }
        var current = root
        var prev : Node<T>?
        while current != nil {
            if current!.data == value {
                return (current, prev)
            }else if value < current!.data {
                prev = current
                current = current?.left
            }else {
                prev = current
                current = current?.right
            }
        }
        return (current, prev)
    }
}

