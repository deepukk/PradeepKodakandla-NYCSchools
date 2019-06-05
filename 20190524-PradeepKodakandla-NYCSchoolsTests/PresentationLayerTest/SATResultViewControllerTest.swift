//
//  SATResultViewControllerTest.swift
//  20190524-PradeepKodakandla-NYCSchoolsTests
//
//  Created by Pradeep kodakandla on 6/5/19.
//  Copyright © 2019 Pradeep Kodakandla. All rights reserved.
//

import XCTest
@testable import _0190524_PradeepKodakandla_NYCSchools

class SATResultViewControllerTest: XCTestCase {
    var SATResultVC: SATResultsViewController?
    
    override func setUp() {
        let satVC = UIStoryboard.viewControllerFrom(storyboard: .main,
                                                    withIdentifier: .resultsVc) as! SATResultsViewController
        
        SATResultVC = satVC
        SATResultVC?.loadViewIfNeeded()
        SATResultVC?.viewModel.resultData = MockSATData.getMockSATData()?.first
    }
    
    func testUpdateSatScore() {
        let data = SATResultVC?.viewModel.resultData
        SATResultVC?.updateSatResultView(result: data)
        XCTAssertEqual(SATResultVC?.numOfTakersLbl.text, "29")
        XCTAssertNotNil(SATResultVC?.mathsAvgScoreLbl.text)
        XCTAssertNotNil(SATResultVC?.readingAvgScoreLbl.text)
        XCTAssertNotNil(SATResultVC?.writingAvgScoreLbl.text)
    }
}
