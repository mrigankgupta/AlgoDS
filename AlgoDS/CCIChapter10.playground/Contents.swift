//: Playground - noun: a place where people can play
import DataStructSet
//q1

func reverseSortedMerge(sml:[Int], scnt:Int, big:inout [Int], bcnt:Int) {
    var se = scnt
    var be = bcnt
    var indx = big.count-1
    while se >= 0 && be >= 0 {
        if sml[se] < big[be] {
            print("big \(be)")
            big[indx] = big[be]
            be -= 1
            indx -= 1
        }else{
            big[indx] = sml[se]
            se -= 1
            indx -= 1
        }
        //        print("index \(indx)")
    }
    while se >= 0 {
        big[indx] = sml[se]
        se -= 1
        indx -= 1
    }
    while be >= 0 {
        big[indx] = big[be]
        be -= 1
        indx -= 1
    }
}
var sml = [1,2,6,8]
var big = [3,4,5,0,0,0,0]
reverseSortedMerge(sml: sml, scnt: sml.count-1, big: &big, bcnt: 2)
print(big)
//q2


//q3

func searchRotated(arr:[Int], item: Int, start: Int, end: Int) -> Int? {
    if start > end {
        return nil
    }
    let m = start + (end - start)/2
    
    if arr[m] == item {
        return m
    } else if arr[start] < arr[end] {
        // normal binary
        if item < arr[m] {
            return searchRotated(arr: arr, item: item, start: start, end: m-1)
        } else {
            return searchRotated(arr: arr, item: item, start: m+1, end: end)
        }
    }else {
        // middle point to the right
        if arr[m] > arr[end] {
            if arr[m] > item && item > arr[start] {
                //search left
                return searchRotated(arr: arr, item: item, start: start, end: m-1)
            }else{
                return searchRotated(arr: arr, item: item, start: m+1, end: end)
            }
        }else {// middle point to the left, middle < end
            if arr[m] < item && item > arr[end] {
                //search Left
                return searchRotated(arr: arr, item: item, start: start, end: m-1)
            }else{
                return searchRotated(arr: arr, item: item, start: m+1, end: end)
            }
        }
    }
}


searchRotated(arr: [7, 10, 14, 15, 16, 19, 20, 25, 1, 3, 4, 5, ], item: 19, start: 0, end: 11)

//q4
func sortedSearchNoSize(arr:[Int], item: Int) -> Int? {
    var start = 0
    var index = start*2
    var current = arr[index]
    while current != -1 && current < item {
        start = start + 1
        index = start*2
        current = arr[index]
    }
    while current == -1 {
        index = index - 1
        current = arr[index]
    }
    return binarySearch(arr: arr, lft: index/2, rgt: index, item: item)
}

func binarySearch(arr: [Int], lft: Int, rgt: Int, item: Int) -> Int? {
    if lft > rgt {
        return nil
    }
    let mdl = lft + (rgt-lft)/2
    let nxt = arr[mdl]
    if nxt == item {
        return mdl+1
    }else if nxt > item {
        return binarySearch(arr: arr, lft: lft, rgt: mdl-1, item: item)
    }else {
        return binarySearch(arr: arr, lft: mdl+1, rgt: rgt, item: item)
    }
}
let arr = [0,1,2,2,2,4,5,6,7,8,9,9,10,11,13,15,16,17,
           -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
           -1,-1,-1,-1,-1,-1,-1,-1]

sortedSearchNoSize(arr: arr, item: 0)

//q5


func sparceSearch(arr:[String], item: String, lft: Int, rgt: Int) -> Int? {
    if lft > rgt {
        return nil
    }
    var mid = lft + (rgt - lft)/2
    if arr[mid].isEmpty {
        var nearL = mid
        var nearR = mid
        while arr[nearL].isEmpty {
            nearL = nearL - 1
        }
        while arr[nearR].isEmpty {
            nearR = nearR + 1
        }
        mid = nearR > nearL ? nearL : nearR
    }
    if arr[mid] == item {
        return mid+1
    }else{
        var fst = [Character](arr[mid])
        var scd = [Character](item)
        if fst[0].ascii() < scd[0].ascii() {
            return sparceSearch(arr: arr, item: item, lft: mid, rgt: rgt)
        }else {
            return sparceSearch(arr: arr, item: item, lft: lft, rgt: mid)
        }
    }
    
}

let sps = ["","at","","","","ball","","","car","","","dad","","",""]
sparceSearch(arr: sps, item: "car", lft: 0, rgt: sps.count-1)

//q6

func divideExternal<T: Comparable>(arr:inout [T], lft: Int, rgt: Int) {
    if lft < rgt {
        let m = lft + (rgt - lft)/2
        divideExternal(arr: &arr, lft: lft, rgt: m)
        divideExternal(arr: &arr, lft: m+1, rgt: rgt)
        merger(arr: &arr, lStart: lft, lEnd: m, rStart: m+1, rEnd: rgt)
    }
}

func merger<T: Comparable>(arr:inout [T], lStart: Int, lEnd: Int, rStart: Int, rEnd: Int) {
    var ls = lStart
    var rs = rStart
    var arL = arr[ls...lEnd]
    var arR = arr[rs...rEnd]
    var idx = ls
    while ls <= lEnd && rs <= rEnd {
        if arL[ls] < arR[rs] {
            arr[idx] = arL[ls]
            ls = ls + 1
        }else{
            arr[idx] = arR[rs]
            rs = rs + 1
        }
        idx = idx + 1
    }
    
    while lEnd >= ls {
        arr[idx] = arL[ls]
        ls = ls + 1
        idx = idx + 1
    }
    while rEnd >= rs {
        arr[idx] = arR[rs]
        rs = rs + 1
        idx = idx + 1
    }
}

var smpl = [2,7,8,3,5,9]
merger(arr: &smpl, lStart: 0, lEnd: 2, rStart: 3, rEnd: 5)
smpl = [1,4,3,6,10,9,2]
divideExternal(arr: &smpl, lft: 0, rgt: smpl.count-1)
smpl
//9
func binarySearch<T: Comparable>(arr: [[T]], srow: Int, scol: Int, row: Int, col: Int, item: T) -> (Int, Int)? {
    if srow > row && scol > col {
        return nil
    }
    if let indexC = bSearchCol(arr: arr, srow: srow, scol: scol, col: col, item) {
        return indexC
    }else if let indexR = bSearchRow(arr: arr, srow: srow, scol: scol, row: row, item) {
        return indexR
    }else {
        return binarySearch(arr: arr, srow: srow+1, scol: scol+1, row: row, col: col, item: item)
    }
}


func bSearchCol<T: Comparable>(arr: [[T]], srow: Int, scol: Int, col: Int, _ item: T) -> (Int, Int)? {
    if scol > col {
        return nil
    }
    let mid = (scol + col)/2
    let current = arr[srow][mid]
    if current == item {
        return (srow, mid)
    }else if item > current {
        return bSearchCol(arr: arr, srow: srow, scol: mid+1, col: col, item)
    }else {
        return bSearchCol(arr: arr, srow: srow, scol: scol, col: mid-1, item)
    }
}

func bSearchRow<T: Comparable>(arr: [[T]], srow: Int, scol: Int, row: Int, _ item: T) -> (Int, Int)? {
    if srow > row {
        return nil
    }
    let mid = (srow + row)/2
    let current = arr[mid][scol]
    if current == item {
        return (mid, scol)
    }else if item > current {
        return bSearchRow(arr: arr, srow: mid+1, scol: scol, row: row, item)
    }else {
        return bSearchRow(arr: arr, srow: srow, scol: scol, row: mid-1, item)
    }
}

let twoD = [[2,5,8,10],[3,7,14,17],[6,9,15,19],[11,13,16,20]]
print(binarySearch(arr: twoD, srow: 0, scol: 0, row: 3, col: 3, item: 2))

//11

class TNode<T: Comparable> {
    var data: T
    var left: TNode<T>?
    var right: TNode<T>?
    init(_ data: T) {
        self.data = data
    }
}

func insert<T: Comparable>(root: TNode<T>?, item: T) -> TNode<T> {
    if root == nil {
        return TNode(item)
    }
    var current = root
    var prev: TNode<T>?
    while current != nil {
        prev = current
        if item <= current!.data {
            current = current?.left
        }else {
            current = current?.right
        }
    }
    if item <= prev!.data {
        prev?.left = TNode(item)
    }else{
        prev?.right = TNode(item)
    }
    return root!
}
var r11: TNode<Int>?
for i in [5,1,4,4,5,9,7,13,3] {
    r11 = insert(root: r11, item: i)
}

func findRank<T: Comparable>(root: TNode<T>?, item: T) -> Int {
    var rank: Int = 0
    if let itemNode = find(root: root, item: item) {
        inorder(root: itemNode.left, total: &rank)
    }
    return rank
}

func inorder<T: Comparable>(root: TNode<T>?, total: inout Int) {
    if root == nil {
        return
    }
    total += 1
    inorder(root: root?.left, total: &total)
    inorder(root: root?.right, total: &total)
}

func find<T: Comparable>(root: TNode<T>?, item: T) -> TNode<T>? {
    if root == nil {
        return nil
    }
    
    if root!.data == item {
        return root
    }else if item <= root!.data {
        return find(root: root?.left, item: item)
    }else {
        return find(root: root?.right, item: item)
    }
}

findRank(root: r11, item: 4)

//12

func peakValley(arr: inout [Int]) {
    arr.sort()
    for i in stride(from: 0, to: arr.count, by: 2) {
        arr.swapAt(i, i+1)
    }
}
var arr12 = [0,4,1,8,7,9]
peakValley(arr: &arr12)

