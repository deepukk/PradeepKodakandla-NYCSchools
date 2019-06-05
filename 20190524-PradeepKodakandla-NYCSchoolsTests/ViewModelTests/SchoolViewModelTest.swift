//
//  SchoolViewModelTest.swift
//  20190524-PradeepKodakandla-NYCSchoolsTests
//
//  Created by Pradeep kodakandla on 6/5/19.
//  Copyright © 2019 Pradeep Kodakandla. All rights reserved.
//

import Foundation
import XCTest
@testable import _0190524_PradeepKodakandla_NYCSchools

class SchoolViewModelTest: XCTestCase {
    
    var schoolVm: SchoolsViewModel?
    
    override func setUp() {
        schoolVm = SchoolsViewModel()
        schoolVm?.dataSource = MockSchoolData.getMaockSchoolData()
        schoolVm?.schl = schoolVm?.dataSource?.first
    }
    
    func testSchoolName() {
        if let schoolName = schoolVm?.schoolName {
            XCTAssertEqual(schoolName, "Clinton School Writers & Artists, M.S. 260")
        }
    }
    
    func testlocation() {
        XCTAssertNotNil(schoolVm?.location)
    }
    
    func testGrades() {
        if let grades = schoolVm?.grades {
            XCTAssertEqual(grades, "6-12")
        }
    }
    func testTotalStudents() {
        if let totalStudents = schoolVm?.totalStudents {
            XCTAssertEqual(totalStudents, "376 students")
        }
    }
    
    func testSubtitle() {
        XCTAssertNotNil(schoolVm?.subtitle)
    }
    
    func testNumOfRows() {
        XCTAssertNotNil(schoolVm?.numOfRows)
    }
    func testNumOfSections() {
        XCTAssertNotNil(schoolVm?.numOfSections)
    }
    func testData() {
        XCTAssertNotNil(schoolVm?.data(at: 1))
        
    }
}

