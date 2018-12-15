import Foundation

func generatePrime(to number:Int) -> [Int] {
    
    var arr = [Bool](repeating: true, count: number)
    
    var prime = 2
    while prime <= Int(sqrt(Double(number))) {
        for i in stride(from: prime*2, through: number-1, by: prime) {
            arr[i] = false
        }
        var idx = prime+1
        var nxt = arr[idx]
        while nxt != true {
            idx += 1
            nxt = arr[idx]
        }
        prime = idx
    }
    
    var final = [Int]()
    for i in 0..<number {
        if arr[i] == true {
            final.append(i)
        }
    }
    return final
}

print("hi")

generatePrime(to: 1202)

func locker(num:Int) -> Int {
    var arr = [Bool](repeating: false, count: num)
    for j in 1..<num {
        for i in stride(from: 0, to: num-1, by: j) {
            arr[i] = !arr[i]
        }
    }
    var count = 0
    for idx in 0..<num {
        if arr[idx] == true {
            count += 1
        }
    }
    return count
}

locker(num: 100)
