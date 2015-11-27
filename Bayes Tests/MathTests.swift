//
//  MathTests.swift
//  Bayes
//
//  Created by Fabian Canas on 5/11/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

import Cocoa
import XCTest
import Bayes

class MathTests: XCTestCase {

    func testProduct() {
        XCTAssertEqual(product([1,2,3,4,5]), 120, "Test positive products")
        XCTAssertEqual(product([-1,2,-3,4,-5]), -120, "Test negative products")
        XCTAssertEqual(product([]), 1, "Product of an empty set should be 1")
        
        XCTAssertEqual(product(Set([1,2,3,4,5])), 120, "Test products of Sets")
    }
    
    func testArgmax() {
        let b = argmax(["a":1,"b":12,"c":-25])!
        XCTAssertEqual(b, "b", "Test Int argmax")
        let a = argmax(["a":100.3,"b":100.2,"c":-25.0])!
        XCTAssertEqual(a, "a", "Test Double/Float argmax")
    }
    
    func testArgmin() {
        let c = argmin(["a":1,"b":12,"c":-25])!
        XCTAssertEqual(c, "c", "Test argmin")
        let a = argmax(["a":100.3,"b":100.2,"c":-100.1])!
        XCTAssertEqual(a, "a", "Test Double/Float argmax")
    }
    
    func testEmptyVararg() {
        let empty :[String: Double] = [:]
        XCTAssertNil(argmax(empty))
    }

}
