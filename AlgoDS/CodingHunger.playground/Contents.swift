import DataStructSet
/*Given an array of integers, find the first missing positive integer in linear time and constant space. In other words, find the lowest positive integer that does not exist in the array. The array can contain duplicates and negative numbers as well.

 For example, the input [3, 4, -1, 1] should give 2. The input [1, 2, 0] should give 3.

 You can modify the input array in-place.*/

func findLowestPositive(arr: [Int]) -> Int {
    var min = 1
    for item in arr {
        if item <= 0 {

        } else if item <= min {
            min = min + 1
        }
    }
    return min
}

findLowestPositive(arr: [3, 4, -1, 1])
findLowestPositive(arr: [1, 2, 0])

//P27
func matchBracket(left: Character, right: Character) -> Bool {
    if left == "(" && right == ")" {
        return true
    }else if left == "[" && right == "]" {
        return true
    }else if left == "{" && right == "}" {
        return true
    }
    return false
}

func wellFormed(seq: String) -> Bool {
    var items = [Character](seq)
    var stack = Stack<Character>()
    if items.count % 2 == 1 {
        return false
    }
    stack.push(items[0])
    var indx = 1
    var match = 0
    while indx < items.count  {
        if let top = stack.top(), matchBracket(left: top, right: items[indx]) {
            stack.pop()
            match = match + 1
        }else{
            stack.push(items[indx])
        }
        indx = indx + 1
    }
    print(match)
    return match == items.count/2 ? true : false
}
wellFormed(seq: "([])[]({}){(})")
wellFormed(seq: "([])[]({}){}")

//P3

func serialize<T>(root: Node<T>?) {
    if root == nil {
        return
    }
    var current = root!
    var queue = Queue<Node<T>>()
    queue.append(current)
    while queue.count() > 0 {
        current = queue.remove()!
        print(current.data)
        if let left = current.left {
            queue.append(left)
        }
        if let right = current.right {
            queue.append(right)
        }
    }
}
var binaryTree = BinaryTree()
var sr: Node<Int>?
for elem in 1...10 {
    sr = binaryTree.levelOrderInsert(root: sr, data: elem)
}
serialize(root: sr)

//leetcode 54
//REDO
/*#65
Given a N by M matrix of numbers, print out the matrix in a clockwise spiral.

For example, given the following matrix:

[[1,  2,  3,  4,  5],
[6,  7,  8,  9,  10],
[11, 12, 13, 14, 15],
[16, 17, 18, 19, 20]]
 output
 1
 2
 3
 4
 5
 10
 15
 20
 19
 18
 17
 16
 11
 6
 7
 8
 9
 14
 13
 12*/

func spiralTraversal(mat:inout [[Int]], row: Int, col:Int) {
    let total = row*col
    var index = 0
    var r = 0
    var c = 0
    while index < total {
        while c < col && mat[r][c] > 0 {
            print(mat[r][c])
            mat[r][c] = -mat[r][c]
            c+=1
        }
        r+=1
        c-=1
        while r < row && mat[r][c] > 0 {
            print(mat[r][c])
            mat[r][c] = -mat[r][c]
            r+=1
        }
        c-=1
        r-=1
        while c >= 0 && mat[r][c] > 0 {
            print(mat[r][c])
            mat[r][c] = -mat[r][c]
            c-=1
        }
        r-=1
        c+=1
        while r >= 0 && mat[r][c] > 0 {
            print(mat[r][c])
            mat[r][c] = -mat[r][c]
            r-=1
        }
        c+=1
        r+=1
        index+=1

    }
}

var mat = [[1,  2,  3,  4,  5],
           [6,  7,  8,  9,  10],
           [11, 12, 13, 14, 15],
           [16, 17, 18, 19, 20]]
print("spiral")
spiralTraversal(mat: &mat, row: 4, col: 5)
var mat1 = [[1,  2,  3],
           [6,  7,  8],
           [11, 12, 13],
           [16, 17, 18]]
spiralTraversal(mat: &mat1, row: 4, col: 3)

func spiralPrint(_ mat: [[Int]]) {
    let row = mat.count-1
    let col = mat[0].count-1
    var total = (row+1) + (col+1)
    var r = 0
    var c = 0
    var ri = 0
    var ci = 0
    while total > 0 {
        while c <= col - ci/2 {
            print(mat[r][c])
            c += 1
        }
        ri += 1
        c -= 1
        r += 1
        while r <= row - ri/2 {
            print(mat[r][c])
            r += 1
        }
        ci += 1
        r -= 1
        c -= 1

        while c-ci/2 >= 0 {
            print(mat[r][c])
            c -= 1
        }
        ri += 1
        c += 1
        r -= 1

        while r-ri/2 >= 0 {
            print(mat[r][c])
            r -= 1
        }
        ci += 1
        r += 1
        c += 1
        total -= 1
    }
}

spiralPrint([[1,2,3,4],[5,6,7,8],[9,10,11,12], [13,14,15,16]])
print("shit")
spiralPrint([
    [1, 2, 3, 4],
    [5, 6, 7, 8],
    [9,10,11,12]])

spiralPrint([
    [1, 2],
    [3, 4],
    [5,6]])
spiralPrint([
    [1, 2],
    [3, 4]])

func spiralOrder(_ mat: [[Int]]) {
    var rend = mat.count-1
    var cend = mat[0].count-1
    var rstart = 0
    var cstart = 0
    while cstart <= cend || rstart <= rend {

        for c in cstart...cend {
            print(mat[rstart][c])
        }
        rstart += 1

        for r in rstart...rend {
            print(mat[r][cend])
        }
        cend -= 1

        if cstart <= cend {
            for c in (cstart...cend).reversed() {
                print(mat[rend][c])
            }
        }
        rend -= 1

        if rstart <= rend {
            for r in (rstart...rend).reversed() {
                print(mat[r][cstart])
            }
        }
        cstart += 1
    }

}
print("spiral")
spiralOrder([[1,2,3,4],[5,6,7,8],[9,10,11,12], [13,14,15,16]])

/*#476
You are given an array of length n + 1 whose elements belong to the set {1, 2, ..., n}. By the pigeonhole principle, there must be a duplicate. Find it in linear time and space.
*/

func onlySingleRepeat(_ arr: [Int]) -> Int? {
    var copy = arr
    for item in copy {
        copy[item-1] = -copy[item-1]
    }
    for (index, item) in copy.enumerated() {
        if item > 0 {
            return index+1
        }
    }
    return nil
}

onlySingleRepeat([1,2,5,4,3,5])


