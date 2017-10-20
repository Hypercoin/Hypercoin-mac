//
//  CurrencyTypeTests.swift
//  HypercoinTests
//
//  Created by Axel Etcheverry on 20/10/2017.
//  Copyright © 2017 Hypercoin. All rights reserved.
//

import XCTest
@testable import Hypercoin

class CurrencyTypeTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testIteratesOnCurrencyType() {
        XCTAssertEqual(31, CurrencyType.allValues.count)

        XCTAssertEqual("eur", CurrencyType.eur.rawValue)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
