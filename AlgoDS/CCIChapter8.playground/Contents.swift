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


