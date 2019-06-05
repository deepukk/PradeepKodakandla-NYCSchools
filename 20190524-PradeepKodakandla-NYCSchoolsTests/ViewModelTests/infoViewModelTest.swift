//
//  infoViewModelTest.swift
//  20190524-PradeepKodakandla-NYCSchoolsTests
//
//  Created by Pradeep kodakandla on 6/5/19.
//  Copyright © 2019 Pradeep Kodakandla. All rights reserved.
//

import Foundation
import XCTest
@testable import _0190524_PradeepKodakandla_NYCSchools
class infoViewModelTest: XCTestCase {
    var infoVM: infoViewModel?
    override func setUp() {
        infoVM = infoViewModel()
        infoVM?.selectedSchool = MockSchoolData.getMaockSchoolData()?.first
    }
    func testSelectedDbn() {
        if let selectedDBN = infoVM?.selectedDbn {
            XCTAssertEqual(selectedDBN, "02M260")
        }
    }
    func testSubwayArray() {
        XCTAssertNotNil(infoVM?.subwayArray)
        
    }
    func testBusArray() {
        XCTAssertNotNil(infoVM?.busArray)
    }
    
    func testNumOfRows() {
        XCTAssertNotNil(infoVM?.numOfRows)
    }
    func testNumOfSections() {
        XCTAssertNotNil(infoVM?.numOfSections)
    }
}
