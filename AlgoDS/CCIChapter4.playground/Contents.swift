//
//  CCIChapter4.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 26/03/18.
//  Copyright © 2018 Gupta, Mrigank. All rights reserved.
//

import Foundation
import DataStructSet

var adList = [Adjacency]()
let cn = [[2],[2],[0,1,3],[2,4],[7,9,10,5],[4,6],[5],[4,9],[9],[8,4],[4]]
for i in 0..<cn.count {
    adList.append(Adjacency(list: cn[i], visited: false))
}

dfsGraph(start: 3, arr: &adList)

adList.removeAll()
let cn1 = [[1,4,5],[3,4],[1],[2,4],[],[]]
for i in 0..<cn1.count {
    adList.append(Adjacency(list: cn1[i], visited: false))
}
//dfsGraph(start: 0, arr: &adList)

print("bfs")
bfsGraph(start: 0, arr: &adList)
print("tree")


//2

var sarr = [1,2,3,4,5,6,7,8,9]

func makeBSTree<T:Comparable>(arr:[T], left:Int, right:Int)-> Node<T>? {
    if left > right {
        return nil
    }
    let mid = (left+right)/2
    let root = Node(data: arr[mid])
    root.left = makeBSTree( arr: arr, left: left, right: mid-1)
    root.right = makeBSTree( arr: arr, left: mid+1, right: right)
    return root
}
var fu:Node<Int>?
fu = makeBSTree(arr: sarr, left: 0, right: sarr.count-1)

//3

func levelOrderTraversalViaQueue<T>(root:Node<T>) {
    var qu = Queue<Node<T>>()
    qu.add(root)
    while qu.count() > 0 {
        let nxt = qu.remove()
        print(nxt!.data)
        if let lft = nxt?.left {
            qu.add(lft)
        }
        if let rgt = nxt?.right {
            qu.add(rgt)
        }
    }
}

struct LevelNode<T> {
    var node: Node<T>
    var level: Int
}

func listOfDepthBFS<T>(root:Node<T>) -> [SNode<T>] {
    var qu = Queue<LevelNode<T>>()
    var list = [SNode<T>]()
    var level = 0
    var head: SNode<T>?
    qu.add(LevelNode(node: root, level: level+1))
    while qu.count() > 0 {
        let nxt:LevelNode<T> = qu.remove()!
        if level == nxt.level {
            var current = head
            var prev:SNode<T>?
            while current != nil {
                prev = current
                current = current?.next
            }
            prev?.next = SNode(data: nxt.node.data)
        }else {
            level = nxt.level
            if head != nil {
                list.append(head!)
            }
            head = SNode(data: nxt.node.data)
        }
        if let lft = nxt.node.left {
            qu.add(LevelNode(node: lft, level: level+1))
        }
        if let rgt = nxt.node.right {
            qu.add(LevelNode(node: rgt, level: level+1))
        }
    }
    list.append(head!)
    return list
}



func levelOrderInsert<T>(root:Node<T>?, val:T?) -> Node<T> {
    if root == nil && val != nil {
        return Node(data: val!)
    }
    var qu = Queue<Node<T>>()
    qu.add(root!)
    while qu.count() > 0 {
        let nxt = qu.remove()
        if let lft = nxt?.left {
            qu.add(lft)
        }else{
            if let val = val {
                nxt?.left = Node(data: val)
            }
            break
        }
        if let rgt = nxt?.right {
            qu.add(rgt)
        }else{
            if let val = val {
                nxt?.right = Node(data: val)
            }
            break
        }
    }
    return root!
}

func height<T>(root:Node<T>?) -> Int {
    if root == nil {
        return -1
    }
    return max(height(root: root?.left), height(root: root?.right)) + 1
}

func listOfDepthDFS<T>(root: Node<T>) -> [SNode<T>] {
    let h = height(root: root)
    var list = [SNode<T>]()
    for i in 0...h {
        var levelList:SNode<T>?
        levelOrderTraversal(root: root, plevel: i, clevel: h, lList: &levelList)
        list.append(levelList!)
        levelList = nil
    }
    return list
}

func levelOrderTraversal<T>(root:Node<T>?, plevel:Int, clevel:Int, lList:inout SNode<T>?) {
    if root == nil {
        return
    }
    if plevel == clevel {
        if lList == nil {
            lList = SNode(data: root!.data)
        }else {
            var current = lList
            var prev : SNode<T>?
            while current != nil {
                prev = current
                current = current?.next
            }
            prev?.next = SNode(data: root!.data)
        }
    }
    
    levelOrderTraversal(root: root?.left, plevel: plevel, clevel:clevel-1, lList: &lList)
    levelOrderTraversal(root: root?.right, plevel: plevel, clevel:clevel-1, lList: &lList)
}

var rsh : Node<Int>?
for i in 1...5 {
    rsh = levelOrderInsert(root: rsh, val: i)
}
levelOrderTraversalViaQueue(root: rsh!)
var l = listOfDepthDFS(root: rsh!)
var s = SinglyLinkedList<Int>()
var level = 0
for item in l.reversed() {
    level = level + 1
    print("level \(level)")
    s.print(root: item)
}
l = listOfDepthBFS(root: rsh!)
level = 0
for item in l {
    level = level + 1
    print("level \(level)")
    s.print(root: item)
}
//4

func checkBalance<T>(root:Node<T>?) -> Bool {
    var levelList = [[Int]]()
    height(root: root, levelList: &levelList)
    for pair in levelList {
        if pair.count == 2 {
            if abs(pair[0] - pair[1]) > 1 {
                return false
            }
        }
    }
    return true
}
func height<T>(root:Node<T>?, levelList:inout [[Int]]) -> Int {
    if root == nil {
        return -1
    }
    
    let lft = height(root: root?.left, levelList: &levelList)
    let rgt = height(root: root?.right, levelList: &levelList)
    levelList.append([lft,rgt])
    print(lft,rgt)
    return max(lft,rgt) + 1
}

checkBalance(root: rsh)
var testImbalance : Node<Int>?
let bst = BinarySearchTree()
for i in 1...3 {
    testImbalance = bst.insert(root: testImbalance, value: i)
}
bst.inorderTraversal(root: testImbalance)
checkBalance(root: testImbalance)

//5
//REDO: catch is if you think comparing simple left < root < right will work,
// it won't in case of full tree traversal example fake nodes
//
func validateBST<T: Comparable>(root:Node<T>) -> Bool {
    var qu = Queue<Node<T>>()
    qu.add(root)
    while qu.count() > 0 {
        let nxt = qu.remove()!
        if let lft = nxt.left {
            if lft.data < nxt.data {
                qu.add(lft)
            }else{
                return false
            }
        }
        if let rgt = nxt.right {
            if rgt.data > nxt.data {
                qu.add(rgt)
            }else{
                return false
            }
        }
    }
    return true
}

func isValidBST<T: Comparable>(root: Node<T>?) -> Bool {
    if root == nil {
        return true
    }
    var prev: T?  = nil
    return inOrder(root, prev: &prev)
}

func inOrder<T: Comparable>(_ root: Node<T>?, prev: inout T?) -> Bool {
    if root == nil {
        return true
    }

    let left = inOrder(root?.left, prev: &prev)
    if prev != nil && root!.data <= prev! {
        return false
    }
    prev = root?.data
    let right = inOrder(root?.right, prev: &prev)
    return left == true && right == true
}

var fake1: Node<Int>?
for i in [4,2,5,1,3] {
    fake1 = levelOrderInsert(root: fake1, val: i)
}
var fake2: Node<Int>?
for i in [10,5,15,1,7,6,20] {
    fake2 = levelOrderInsert(root: fake2, val: i)
}
print("testing")
levelOrderTraversalViaQueue(root: fake2!)
isValidBST(root: fu)
isValidBST(root: rsh)
isValidBST(root: testImbalance)
isValidBST(root: fake1)
isValidBST(root: fake2)

validateBST(root: fu!)
validateBST(root: rsh!)
validateBST(root: testImbalance!)
validateBST(root: fake1!)
validateBST(root: fake2!)

//8

class PNode<T>{
    var data: T
    var left:PNode?
    var right:PNode?
    var parent:PNode?
    init(data:T) {
        self.data = data
    }
}

func find<T:Comparable>(root:PNode<T>?, val:T) -> PNode<T>? {
    if root == nil {
        return nil
    }
    var st = Stack<PNode<T>>()
    st.push(root!)
    while st.count() > 0 {
        let nxt = st.pop()!
        if nxt.data == val {
            return nxt
        }
        if let lft = nxt.left {
            st.push(lft)
        }
        if let rgt = nxt.right {
            st.push(rgt)
        }
    }
    return nil
}

func level<T>(_ node:PNode<T>?) -> Int {
    var curnt:PNode<T>? = node
    var level = -1
    while curnt != nil {
        level = level + 1
        curnt = curnt?.parent
    }
    return level
}

func firstCommonAncestor<T:Comparable>(root:PNode<T>, a:T, b:T) -> PNode<T>? {
    let aNode = find(root: root, val: a)
    let bNode = find(root: root, val: b)
    let la = level(aNode)
    let lb = level(bNode)
    var big:PNode<T>?
    var small:PNode<T>?
    if let aNode = aNode, let bNode = bNode {
        big = aNode
        small = bNode
        var diff = la - lb
        if lb > la {
            small = aNode
            big = bNode
            diff = lb - la
        }
        while diff > 0 {
            big = big?.parent
            diff = diff - 1
        }
        
        while big != nil && small != nil {
            if big!.data == small!.data {
                return big
            }
            big = big?.parent
            small = small?.parent
        }
        return root
    }
    
    return nil
}

//LowestCommmonAncestor
// Via Recursion O(n)

func lca(root: PNode<Int>?, fst: Int, sec: Int) -> PNode<Int>? {
    if root == nil {
        return nil
    }
    if root!.data == fst || root!.data == sec {
        return root
    }

    let left = lca(root: root?.left, fst: fst, sec: sec)
    let right = lca(root: root?.right, fst: fst, sec: sec)

    if left != nil && right != nil {
        return root
    }

    return left == nil ? right : left
}


func insertLevelOrdr<T>(root:PNode<T>?, val:T) -> PNode<T> {
    if root == nil {
        return PNode(data: val)
    }
    var qu = Queue<PNode<T>>()
    qu.add(root!)
    while qu.count() > 0 {
        let nxt:PNode<T> = qu.remove()!
        if let lft = nxt.left {
            qu.add(lft)
        }else {
            nxt.left = PNode(data: val)
            nxt.left?.parent = nxt
            break
        }
        
        if let rgt = nxt.right {
            qu.add(rgt)
        }else {
            nxt.right = PNode(data: val)
            nxt.right?.parent = nxt
            break
        }
    }
    return root!
}
var fca: PNode<Int>?
for i in 1...10 {
    fca = insertLevelOrdr(root: fca, val: i)
}
lca(root: fca, fst: 2, sec: 5)?.data
print(firstCommonAncestor(root: fca!, a: 6, b: 8)?.data)
//10

//trying something different for finding
func findNode<T:Comparable>(root:Node<T>?, val:T, elem:inout Node<T>?) {
    if root == nil {
        return
    }
    if root!.data == val {
        elem = root!
        return
    }
    findNode(root: root!.left, val: val, elem: &elem)
    findNode(root: root?.right, val: val, elem: &elem)
}

func match<T>(root:Node<T>?, list:inout [T?]) {
    if root == nil {
        let empty:T? = nil
        list.append(empty)
        return
    }
    list.append(root?.data)
    match(root: root?.left, list: &list)
    match(root: root?.right, list: &list)
}

func checkSubtree<T:Comparable>(big:Node<T>, smal:Node<T>) -> Bool {
    var head:Node<T>?
    findNode(root: big, val: smal.data, elem: &head)
    if let head = head {
        var lb = [T?]()
        match(root: head, list: &lb)
        var ls = [T?]()
        match(root: smal, list: &ls)
        var index = 0
        for s in ls {
            if s != lb[index] {
                return false
            }
            index += 1
        }
        return true
    }
    return false
}

func preorderMatch<T:Comparable>(big:Node<T>?, small:Node<T>?, check:inout Bool) {
    if small == nil {
        return
    }
    
    if big == nil || big!.data != small!.data {
        check = false
        return
    }
    preorderMatch(big: big?.left, small: small?.left, check: &check)
    preorderMatch(big: big?.right, small: small?.right, check: &check)
}

func checkSubtreeNoMem<T:Comparable>(big:Node<T>, smal:Node<T>) -> Bool {
    var head:Node<T>?
    findNode(root: big, val: smal.data, elem: &head)
    var check = true
    if let head = head {
        preorderMatch(big: head, small: smal, check: &check)
    }
    return check
}
var big:Node<Int>?
var smal:Node<Int>?

let bs = BinarySearchTree()

for i in [50,40,30,5,15,45,60,70,65,65,80] {
    big = bs.insert(root:big, value: i)
}
for i in [30,5,15] {
    smal = bs.insert(root:smal, value: i)
}
checkSubtree(big: big!, smal: smal!)
checkSubtreeNoMem(big: big!, smal: smal!)


//11 Return Rondom node

class RNode<T> {
    var data: T
    var left: RNode<T>?
    var right: RNode<T>?
    var size: Int
    init(_ data:T, size:Int) {
        self.data = data
        self.size = size
    }
}

func insert<T : Comparable>(root:RNode<T>?, val:T) -> RNode<T> {
    
    if root == nil {
        return RNode(val, size: 1)
    }
    root?.size += 1
    if val <= root!.data {
        root?.left = insert(root: root?.left, val: val)
    }else{
        root?.right = insert(root: root?.right, val: val)
    }
    return root!
}

func find<T:Comparable>(root:RNode<T>?, val:T) -> RNode<T>? {
    
    if root == nil {
        return nil
    }
    
    if root!.data == val {
        return root
    }else if root!.data < val {
        return find(root: root?.left, val: val)
    }else {
        return find(root: root?.right, val: val)
    }
}

func randomNode<T:Comparable>(root:RNode<T>) -> RNode<T> {
    let size = root.size
    let randm = Int(arc4random_uniform(UInt32(size)))+1
    let lSize:Int = root.left?.size ?? 0
    if root.size == randm {
        return root
    }else if randm <= lSize {
        return randomNode(root: root.left!)
    }else{
        return randomNode(root: root.right!)
    }
}

func findRandm<T:Comparable>(root:RNode<T>, rndm:Int) -> RNode<T> {
    let lSize:Int = root.left?.size ?? 0
    let size = root.size
    
    if size == rndm {
        return root
    }else if rndm <= lSize {
        return findRandm(root: root.left!, rndm:rndm)
    }else{
        return findRandm(root: root.right!, rndm:size - rndm)
    }
}
func randomNodeEffi<T:Comparable>(root:RNode<T>) -> RNode<T> {
    let size = root.size
    let randm = Int(arc4random_uniform(UInt32(size)))+1
    return findRandm(root: root, rndm: randm)
}

var rn : RNode<Int>?

for i in [10,3,4,6,8,9,2,1] {
    rn = insert(root: rn, val: i)
}
for _ in 0...100 {
    randomNode(root: rn!).data
}

for _ in 0...100 {
    randomNodeEffi(root: rn!).data
}


//12 SumOfNodesPath

func sumOfPathForNode(root:PNode<Int>?, sum:Int, val:Int) -> Int {
    if root == nil {
        return 0
    }
    let s = sum+root!.data
    var count = 0
    if s == val {
        count += 1
    }
    
    count += sumOfPathForNode(root: root?.left, sum: s , val: val)
    count += sumOfPathForNode(root: root?.right, sum: s, val: val)
    return count
}


func countSumOfPath(root:PNode<Int>,val:Int) -> Int {
    var count = 0
    var qu = Queue<PNode<Int>>()
    qu.add(root)
    while qu.count() > 0 {
        let nxt = qu.remove()!
        let sum = 0
        count += sumOfPathForNode(root: nxt, sum: sum, val: val)
        if let lft = nxt.left {
            qu.add(lft)
        }
        if let rgt = nxt.right {
            qu.add(rgt)
        }
    }
    return count
}

var smp: PNode<Int>?
for i in [10,5,-3,3,2,11,3,-2,1] {
    smp = insertLevelOrdr(root: smp, val: i)
}

print(countSumOfPath(root: smp!, val: 7))


// BST sequence
/*wrong implementation
 func preorderSeq<T>(root:Node<T>?) -> [T]? {
 if root == nil {
 return nil
 }
 var seq = [T]()
 var st = Stack<Node<T>>()
 st.push(root!)
 while st.count() > 0 {
 let nxt = st.pop()!
 seq.append(nxt.data)
 if let lft = nxt.left {
 st.push(lft)
 }
 if let rgt = nxt.right {
 st.push(rgt)
 }
 }
 return seq
 }
 
 func bstSequence<T>(root:Node<T>) ->[[T]] {
 
 let lftSeq = preorderSeq(root: root.left)
 let rgtSeq = preorderSeq(root: root.right)
 var seq = [[T]]()
 var initial = [T]()
 initial.append(root.data)
 if lftSeq == nil {
 initial.append(contentsOf: rgtSeq!)
 seq.append(initial)
 return seq
 }else if rgtSeq == nil {
 initial.append(contentsOf: lftSeq!)
 seq.append(initial)
 return seq
 }
 var combination = [T]()
 for l in 0..<lftSeq!.count {
 for r in 0..<rgtSeq!.count {
 combination.append(contentsOf: initial)
 combination.append(contentsOf: rgtSeq!.prefix(upTo: r))
 combination.append(contentsOf: lftSeq!.prefix(upTo: l))
 combination.append(contentsOf: rgtSeq!.suffix(from: r))
 combination.append(contentsOf: lftSeq!.suffix(from: l))
 seq.append(combination)
 combination.removeAll()
 }
 
 }
 return seq
 }
 
 var bstS: Node<Int>?
 for i in [5,3,2,7,6] {
 bstS = bs.insert(root: bstS, value: i)
 }
 var list = bstSequence(root: bstS!)
 print(list)*/
