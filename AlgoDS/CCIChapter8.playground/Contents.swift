//Dynamic programming
//1

func stairCase(steps: Int, covered: Int, total:inout Int) {
    if covered >= steps {
        return
    }
    total = total+1
    stairCase(steps: steps, covered: (covered+1), total: &total)
    total = total + 1
    stairCase(steps: steps, covered: (covered+2), total: &total)
    total = total + 1
    stairCase(steps: steps, covered: (covered+3), total: &total)
}
var t = 0
stairCase(steps: 1, covered: 0, total: &t)
print(t)

func countWays(steps: Int) -> Int {
    if steps < 0 {
        return 0
    }else if steps == 1 {
        return 1
    }else {
        return countWays(steps: steps-1) + countWays(steps: steps-2) + countWays(steps: steps-3)
    }
}
countWays(steps: 10)

//3

func magicIndex(arr: [Int], lft: Int, rgt: Int) -> Int? {
    if lft > rgt {
        return nil
    }
    let mid = (lft + rgt)/2
    if mid == arr[mid] {
        return mid
    }else if arr[mid] > mid {
        return magicIndex(arr: arr, lft: lft, rgt: mid-1)
    }else{
        return magicIndex(arr: arr, lft: mid+1, rgt: rgt)
    }
}




magicIndex(arr: [-40,-20,-1,1,2,3,5,7,9,12,13], lft: 0, rgt: 10)


func paste(arr: [String]) -> String {
//    return arr.flatMap { (item) -> String in
//        return item
//    }

//    let joined: String = arr.reduce(String("")) { (final, item) -> String in
//        return final.append(item)
//    }
    var joined: String = arr.reduce("") { (final, item) -> String in
        return final + item + ";"
    }
    joined.removeLast()
    return joined
}

paste(arr: ["lol","fol"])


func usernameDisparity(inputs: [String]) -> [Int] {

    var sums = [Int]()
    for item in inputs {
        var chArr = [Character](item)
        var i = 0
        var j = i
        var sum = 0
            while i < chArr.count {
                j = i
                var k = 0
                for j in j...chArr.count-1 {
                    if chArr[j] == chArr[k] {
                        sum += 1
                    }else{
                        break
                    }
                    k += 1
                }
                i += 1
            }

        sums.append(sum)
    }
    return sums
}

usernameDisparity(inputs: ["ababaa"])
