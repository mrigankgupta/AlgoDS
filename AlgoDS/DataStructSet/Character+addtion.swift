//
//  Character+addtion.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 22/06/18.
//  Copyright © 2018 Gupta, Mrigank. All rights reserved.
//

import Foundation

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
