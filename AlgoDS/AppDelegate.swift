//
//  AppDelegate.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 05/06/19.
//  Copyright © 2019 Gupta, Mrigank. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UISplitViewControllerDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
//        showDataRaceAndAccessRaceMultiThread()
//        showRaceMultiThread()
        showNoRaceNoDataRace()
        testStockUpdate()
        testStockUpdateConcurrent()
        testReaderWriter()
        return true
    }

    func showDataRaceAndAccessRaceMultiThread() {
        var test = Test()
        var count = 100
        let myConcurrent = DispatchQueue(label:"concurrentQueue" , attributes: .concurrent)
        myConcurrent.async {
            while count > 0 {
                test.change("Thread1 \(count)")
                print(test.name)
                count -= 1
            }
        }

        DispatchQueue.global().async {
            while count > 0 {
                test.change("Thread2 \(count)")
                print(test.name)
                count -= 1
            }
        }
    }

    func showRaceMultiThread() {
        let test = TestRace()
        var count1 = 100
        var count2 = 100
        let group = DispatchGroup()
        let myConcurrent = DispatchQueue(label:"concurrentQueue" , attributes: .concurrent)
        myConcurrent.async(group: group) {
            while count1 > 0 {
                test.raceExample("ThreadOne")
                count1 -= 1
            }
        }

        DispatchQueue.global().async(group: group) {
            while count2 > 0 {
                test.raceExample("ThreadTwo")
                count2 -= 1
            }
        }
        group.notify(queue: DispatchQueue.main) {
            print("count not sync", test.count)
            print("safe from access race but not safe from Race final count", test.countOne)
        }
    }
    
    func showNoRaceNoDataRace() {
        let test = TestRace()
        var count1 = 100
        var count2 = 100
        let group = DispatchGroup()
        let myConcurrent = DispatchQueue(label:"concurrentQueue" , attributes: .concurrent)
        myConcurrent.async(group: group) {
            while count1 > 0 {
                test.safeFromRaceAndDataRace()
                count1 -= 1
            }
        }
        
        DispatchQueue.global().async(group: group) {
            while count2 > 0 {
                test.safeFromRaceAndDataRace()
                count2 -= 1
            }
        }
        group.notify(queue: DispatchQueue.main) {
            print("safe from all race", test.countTwo)
        }
    }
    
    func textStock() {
        var stock  = Stock()
        stock.update("APPL", val: 400)
        stock.update("GOGL", val: 400)
        stock.update("AMZN", val: 250)
        stock.update("GOGL", val: 300)
        stock.update("AMZN", val: 10)
        stock.update("AMZN", val: 600)
        stock.update("APPL", val: 100)
        stock.update("AMZN", val: 100)
        stock.update("GOGL", val: 80)
        stock.update("AMZN", val: 90)
        
        stock.maxTraded(1)
    }
    
    
    
    
    func testStockUpdate() {
        let stock  = StockClass()

        var count1 = 1000
        var count2 = 1005
        
        let group = DispatchGroup()
        let myConcurrent = DispatchQueue(label:"concurrentQueue", attributes: .concurrent)
        let time = Date().timeIntervalSince1970

        myConcurrent.async(group: group) {
            while count1 > 0 {
                stock.update("APPL", val: 1)
                count1 -= 1
            }
        }
        
        DispatchQueue.global().async(group: group) {
            while count2 > 0 {
                stock.update("GOGL", val: 1)
                count2 -= 1
            }
        }
        
        DispatchQueue.concurrentPerform(iterations: 10000) { interation in
            print(stock.maxTraded(1))
//            usleep(1010)
        }
        group.notify(queue: DispatchQueue.main) {
            print("finally", stock.stockMap["APPL"], stock.stockMap["GOGL"])
            print(stock.maxTraded(1))
            print("elapsed time", Date().timeIntervalSince1970 - time)
        }
    }
    
    func testStockUpdateConcurrent() {
        let stock  = StockClass()
        
        var count1 = 1000
        var count2 = 1005
        
        let group = DispatchGroup()
        let myConcurrent = DispatchQueue(label:"concurrentQueue", attributes: .concurrent)
        let time = Date().timeIntervalSince1970
        
        myConcurrent.async(group: group) {
            while count1 > 0 {
                stock.updateConcurrent("APPL", val: 1)
                count1 -= 1
            }
        }
        
        DispatchQueue.global().async(group: group) {
            while count2 > 0 {
                stock.updateConcurrent("GOGL", val: 1)
                count2 -= 1
            }
        }
        
        DispatchQueue.concurrentPerform(iterations: 10000) { interation in
            print(stock.maxTradedCon(1))
            //            usleep(1010)
        }
        group.notify(queue: DispatchQueue.main) {
            print("finally", stock.stockMapCon["APPL"], stock.stockMapCon["GOGL"])
            print(stock.maxTradedCon(1))
            print("elapsed time Concurrent", Date().timeIntervalSince1970 - time)
        }
    }
    
    func testReaderWriter() {
        let rw  = ReaderWriter()
        
        var count1 = 1000
        var count2 = 10000
        
        let group = DispatchGroup()
        let myConcurrent = DispatchQueue(label:"concurrentQueue", attributes: .concurrent)
        
        myConcurrent.async(group: group) {
            while count1 > 0 {
                rw.write()
                count1 -= 1
            }
        }
        
        DispatchQueue.global().async(group: group) {
            while count2 > 0 {
                rw.read()
                count2 -= 1
            }
        }

        group.notify(queue: DispatchQueue.main) {
            print("Reader writer problem \(rw.sharedRes)")
        }
        
    }
}


