//
//  CCIChapter1.swift
//  
//
//  Created by Gupta, Mrigank on 02/02/18.
//

import Foundation

/*String f@#$king shit.... Points to remember
 String.sorted() returns character array
 Strings looping is difficult, string subscript "[]" can only be done
 using indeces.
 If you want to remove something from String while enumerating
 use str.indices.reversed() as its safe to remove element while traversing in reverse order
 as after removal of an element, trailing elements of that array needs to be shifted one place left
 
 //array of Characters
 let charArr1 = [Character](myString)
 
 //array of String.element
 let charArr2 = Array(myString)
 
 for char in myString {
 //char is of type Character
 }
 */
extension Character {
    public func unicodeValue() -> UInt32? {
        if let uniVal = self.unicodeScalars.first?.value {
            return uniVal
        }
        return nil
    }
    public func ascii() -> Int {
        if let val = self.unicodeValue() {
            return Int(bitPattern:UInt(val))//TODO:Remind yourself
        }
        return -1
    }
}
//Q1
func uniqueChar(arr:[Character], range:Int) -> Bool {
    var charSet = [Int](repeating: 0, count: range)
    for char in arr {
        guard let indexUInt32 = char.unicodeValue() else { return false }
        let index = Int(bitPattern: UInt(indexUInt32))
        if charSet[index] == 1 {
            return false
        }
        charSet[index] = 1
    }
    return true
}

//Q2
func anagram(str1:String, str2:String) -> Bool {
    var copy = str2
    if str1.count != copy.count {
        return false
    }
    for ch1 in str1 {
        for i in copy.indices.reversed() {//TODO:Remind yourself
            if ch1 == copy[i] {
                copy.remove(at: i)
                break;
            }
        }
    }
    return copy.count == 0
}

//anagram(str1: "abaac", str2: "aaabc")

//Failed
func anagramXOR(str1:String, str2:String) -> Bool {
    if str1.count != str2.count {
        return false
    }
    var sum = str1[str1.startIndex].unicodeValue()! & str1[str1.startIndex].unicodeValue()!
    let index = str1.index(str1.startIndex, offsetBy: 1)
    for ch1 in str1[index...] {
        sum = sum ^ ch1.unicodeValue()!
    }
    for ch2 in str2[str2.startIndex...] {
        sum = sum ^ ch2.unicodeValue()!
    }
    return sum == 0
}

//anagramXOR(str1: "abaacb", str2: "aaafcf")//failed case
//anagramXOR(str1: "abaac", str2: "aaabc")

func anagramSort(str1:String, str2:String) -> Bool {
    var s1 = str1.sorted()
    var s2 = str2.sorted()
    if s1.count != s2.count {
        return false
    }
    for i in 0..<s1.count {
        if s1[i] != s2[i]{
            return false
        }
    }
    return true
}
//anagramSort(str1: "abaac", str2: "aaabc")
//anagramSort(str1: "abaacb", str2: "aaafcf")

//Q3

func urlify(str:String, rep:String) -> String {
    var strCh = [Character](str)
    var repCh = [Character](rep)
    var j=0
    var charEnc = false
    for i in (0..<strCh.count).reversed() {
        if !charEnc {
            if strCh[i] == " " {
                j = j+1
            }
            else if strCh[i] != " " {
                charEnc = true
                print("",strCh[i+j])
                strCh[i+j] = strCh[i]
            }
        }else {
            if strCh[i] != " " {
                strCh[i+j] = strCh[i]
            }else {
                for k in (0..<repCh.count).reversed() {
                    strCh[i+j] = repCh[k]
                    j = j-1
                }
                j = j+1
            }
        }
    }
    return String(strCh)
}
//urlify(str:"Mr John Smith    ", rep: "21%")

//Q4
func permutationPalindrome(str:String) -> Bool {
    let strCh = [Character](str.lowercased())////TODO:Remind yourself
    var charCount = [Int](repeating:0,count:128)
    for ch in strCh {
        let asciiVal = ch.ascii()
        if asciiVal != -1 {
            charCount[asciiVal] = charCount[asciiVal] + 1
        }
    }
    var odd = 0
    for i in 0..<charCount.count {
        if charCount[i]%2 != 0 {
            odd = odd + 1
        }
        if odd > 1 {
            return false
        }
    }
    return true
}

//permutationPalindrome(str: "Tacto coa")

func permutationPalindromeBitWise(str:String) -> Bool {
    let strCh = [Character](str.uppercased())
    var charCount:Int = 0
    
    for ch in strCh {
        var asciiVal = ch.ascii()
        if asciiVal != -1 {
            asciiVal = asciiVal - 65
            let setBit = Int(pow(2.0, Double(asciiVal)))
            charCount = charCount ^ setBit
        }
    }
    var odd = 0
    var flaggedBits = charCount
    var positionBit = 1
    print(charCount)
    while flaggedBits != 0 {
        let isSet = flaggedBits & positionBit
        flaggedBits = ~positionBit & flaggedBits
        if isSet != 0 {
            odd = odd + 1
        }
        positionBit = positionBit << 1
    }
    print(odd)
    return odd <= 1
}

//print(permutationPalindromeBitWise(str: "a"))

//Q5
//improve understanding
func oneAway(str1:String, str2:String) -> Bool {
    let ch1 = [Character](str1)
    let ch2 = [Character](str2)
    let diff = (ch1.count - ch2.count)
    if abs(diff) > 1 {
        return false
    }
    var small = ch2
    var big = ch1
    if diff < 0 {
        small = ch1
        big = ch2
    }
    var away = 0
    var j = 0
    var i = 0
    while i < small.count {
        if small[i] == big[j] {
            i = i + 1
            j = j + 1
        }else if small[i] == big[j+abs(diff)]{
            i = i + 1
            j = j + 1 + abs(diff)
        }else{
            away = away + 1
            i = i + 1
            j = j + 1
        }
        if away > 1 {
            return false
        }
    }
    return true
}

//print(oneAway(str1: "pale", str2: "pal"))
//print(oneAway(str1: "pales", str2: "pale"))
//print(oneAway(str1: "pale", str2: "bale"))
//print(oneAway(str1: "pale", str2: "ale"))
//print(oneAway(str1: "paled", str2: "balub"))
//print(oneAway(str1: "pa", str2: "ba"))

//Q6

func stringCompression(str: String) -> String {
    var chArr = [Character](str)
    var j = 0
    var prev = chArr[j]
    var count = 1
    for i in 1..<chArr.count {
        if prev == chArr[i] {
            count = count + 1
            chArr[j+1] = Character(String(count))
        }else {
            if count > 1 {
                j = j + 2
            }else{
                j = j + 1
            }
            chArr[j] = chArr[i]
            prev = chArr[i]
            count = 1
        }
    }
    return String(chArr[0...j+count-1])
}
//var test = "saasbbbbdcccaaadde"
//print(stringCompression(str: test))

//Q7

func rotationMatrix90Clockwise(img:[[Int]],row:Int, col:Int) -> [[Int]] {
    var rotated = Array(repeating:Array(repeating:0, count:row), count:col)
    for rn in (0..<row) {
        for cn in (0..<col) {
            rotated[rn][cn] = img[col-1-cn][rn]
        }
    }
    return rotated
}

var img = [[1,2,3],[4,5,6],[7,8,9]]

//print(rotationMatrix90Clockwise(img: img, row: 3, col: 3))


func rotationInPlace(img:inout [[Int]], count:Int) -> [[Int]] {
    var temp = [Int](repeating:0,count:count)
    let n = count-1
    for r in 0...n {
        temp[r] = img[0][r] //first row saved
    }
    for r in 0...n {
        img[0][r] = img[n-r][0] //swapped first row with first column
    }
    for r in 0...n {
        img[r][0] = img[n][r]
    }
    for r in 0...n {
        img[n][r] = img[n-r][n]
    }
    for r in 0...n {
        img[r][n] = temp[r]
    }
    print(temp)
    return img
}


//var img1 = [[1,2,3],[4,5,6],[7,8,9]]

//print(rotationInPlace(img: &img1, count: 3))


//Q8

func zeroMatrix(mat:inout [[Int]],row:Int, col:Int) -> [[Int]] {
    
    var markRow = [Int]()
    var markCol = [Int]()
    for r in 0..<row {
        for c in 0..<col {
            if mat[r][c] == 0 {
                markRow.append(r)
                markCol.append(c)
            }
        }
    }
    
    for r in markRow {
        for c in 0..<col {
            mat[r][c] = 0
        }
    }
    for c in markCol {
        for r in 0..<row {
            mat[r][c] = 0
        }
    }
    return mat
}
//var mat = [[1,2,3,0],[0,4,5,6],[7,8,9,10]]

//print(zeroMatrix(mat: &mat, row: 3, col: 4))


func zeroMatrixOSpace(mat:inout [[Int]],row:Int, col:Int) -> [[Int]] {
    
    for r in 0..<row {
        for c in 0..<col {
            if mat[r][c] == 0 {
                mat[0][c] = 0
                mat[r][0] = 0
            }
        }
    }
    print(mat)
    for r in (0..<row).reversed() {//trick go back to start
        for c in (0..<col).reversed() {//trick
            if mat[r][0] == 0 || mat[0][c] == 0 {
                mat[r][c] = 0
            }
        }
    }
    
    return mat
}

//var mat1 = [[1,2,3,0],[0,4,5,6],[7,8,9,10]]
//print(zeroMatrixOSpace(mat: &mat1, row: 3, col: 4))

//Q9
func isStringRotated(str:String, rot:String) -> Bool {
    var strArr = [Character](str)
    var rotArr = [Character](rot)
    if strArr.count != rotArr.count {
        return false
    }
    var count = strArr.count - 1
    var j = 0
    for i in 0...count {
        if strArr[i] == rotArr[j]{
            j = j + 1
        }
    }
    var diff = count - j
    for k in 0..<diff {
        if strArr[k] !=  rotArr[count - diff + k] {
            return false
        }
    }
    return true
}

//print(isStringRotated(str: "waterBottle", rot: "erBottlewat"))
//print(isStringRotated(str: "waterBottle", rot: "Bottlewater"))
//print(isStringRotated(str: "waterBottle", rot: "Bottlewoter"))


