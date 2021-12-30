//
//  ThreadsExperiments.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 05/06/19.
//  Copyright © 2019 Gupta, Mrigank. All rights reserved.
//

import Foundation

//Data Race in struct

struct Test {

    var name: String = ""

    mutating func change(_ name: String) {
        self.name = name
    }

}

class TestRace {

    var serialQueue = DispatchQueue(label: "MySerialQueue")
    var count: Int = 0
    private var _countOne = 0
    private var _countTwo = 0

    
    var countOne: Int {
        // here read and write procedure are atomic individually
        // so there will be no data race or access race when multiple
        // threads gonna access the variable but this doesn't ensure the
        // race which can be seen in func safeFromAccessRaceIncrement()
        get {
            return serialQueue.sync { self._countOne }
        }
        set {
            return serialQueue.async {
                self._countOne = newValue
            }
        }
    }
    
    var countTwo: Int {
        
        get {
            return self._countTwo
        }
        set {
            self._countTwo = newValue
        }
    }
   
    func mutate(_ transform: @escaping (inout Int) -> ()) {
        serialQueue.async {
            transform(&self._countTwo)
        }
    }
    
    func accessRaceIncrement() {
        count += 1
        usleep(2000)
        /*
         simple fix is to put serial Queue sync block.
         this will ensure that two thread will never execute
         following procedure (smilar to mutex or @synchronised of objective C)
         */
//        serialQueue.sync {
//            self.count += 1
//            usleep(2000)
//        }
    }
    
    func safeFromAccessRaceButNotFromRace() {
        countOne += 1
        usleep(2000)
    }
    
    func safeFromRaceAndDataRace() {
        //Will result a correct increment
        mutate { $0 += 1 }
        usleep(2000)
    }
    
    func raceExample(_ name: String) {
//        accessRaceIncrement()
        safeFromAccessRaceButNotFromRace()
    }

}
//Bloomberg

/* create a class which maintains the traded stocks as well as return most traded stocks if asked */
struct Stock {

    var stockMap = [String: Int]()
    var serialQueue = DispatchQueue(label: "MySerialQueue")

    mutating func update(_ stock: String, val: Int) {
        if let old = stockMap[stock] {
            stockMap[stock] = old + val
        } else {
            stockMap[stock] = val
        }
    }

    mutating func maxTraded(_ num: Int) -> [String] {
        let sorted = stockMap.sorted { $0.value > $1.value }
        let keys = sorted[..<num].map { $0.0 }
        return keys
    }


}

/* I was trying to run mutating func in dispatch clouser and complier is giving error "escaping closure cannot capture a mutating self parameter" so I had convert it to class.

 Capturing an inout parameter, including self in a mutating method, becomes an error in an escapable closure literal, unless the capture is made explicit (and thereby immutable).
 https://stackoverflow.com/questions/41940994/closure-cannot-implicitly-capture-a-mutating-self-parameter
 */

//Making thread safe
class StockClass {
    var serialQueue = DispatchQueue(label: "MySerialQueue")
    var concurrent = DispatchQueue(label: "MyConcurrent", attributes: .concurrent)
    private var _stockMap: [String: Int]
    private var _stockMapCon: [String: Int]

    var stockMap: [String: Int] {
        get {
            return serialQueue.sync { _stockMap }
        }
    }
    
    var stockMapCon: [String: Int] {
        get {
            return concurrent.sync { _stockMapCon }
        }
    }
    
    func mutateStock(_ transform: @escaping (inout [String: Int]) -> ()) {
        serialQueue.async {
            transform(&self._stockMap)
        }
    }
    
    func mutateStockConcurrently(_ transform: @escaping (inout [String: Int]) -> ()) {
        concurrent.async(flags: .barrier) {
            transform(&self._stockMapCon)
        }
    }
    
    init() {
        _stockMap = [String: Int]()
        _stockMapCon = [String: Int]()
    }

    func update(_ stock: String, val: Int) {
        mutateStock { stockMap in
            if let old = stockMap[stock] {
                stockMap[stock] = old + val
            }else {
                stockMap[stock] = val
            }
//            usleep(2000)
        }
    }
    
    func updateConcurrent(_ stock: String, val: Int) {
        mutateStockConcurrently { stockMap in
            if let old = stockMap[stock] {
                stockMap[stock] = old + val
            }else {
                stockMap[stock] = val
            }
//            usleep(2000)
        }
    }

    func maxTraded(_ num: Int) -> [String] {
        if num > stockMap.count {
            return []
        }
        let sorted = stockMap.sorted { $0.value > $1.value }
        let keys = sorted[..<num].map{ $0.0 }
        return keys
    }
    
    func maxTradedCon(_ num: Int) -> [String] {
        if num > stockMapCon.count {
            return []
        }
        let sorted = stockMapCon.sorted { $0.value > $1.value }
        let keys = sorted[..<num].map{ $0.0 }
        return keys
    }
}

/* Reader writer problem */
// Any number of readers can read from the shared resource simultaneously, but only one writer can write to the shared resource. When a writer is
// writing data to the resource, no other process can access the resource. A writer cannot write to the resource if there are non zero number of
// readers accessing the resource at that time.

// In iOS dispatch Barrier is used to solve this problem, where single write, multiple read works, what if need to do it traditionally
// one mutex m and a semaphore w. An integer variable read_count is used to maintain the number of readers currently
// accessing the resource. The variable read_count is initialized to 0. A value of 1 is given initially to m and w.
//
class ReaderWriter {
    
    let semaphore: DispatchSemaphore = DispatchSemaphore(value: 1)
    
    var lock = NSLock()
    var readerCount = 0
    
    var sharedRes = 0
    
    func write() {
        semaphore.wait()
        
        // single write
        sharedRes += 1
        semaphore.signal()
    }
    
    func read() {
        lock.lock()
        readerCount += 1
        if readerCount > 0 {
            semaphore.wait()
        }
        lock.unlock()
        
        //multiple read
        print(sharedRes)
        
        lock.lock()
        readerCount -= 1
        if readerCount == 0 {
            semaphore.signal()
        }
        lock.unlock()
    }
}
