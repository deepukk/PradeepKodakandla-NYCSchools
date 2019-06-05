//
//  SchoolsViewControllerTest.swift
//  20190524-PradeepKodakandla-NYCSchoolsTests
//
//  Created by Pradeep kodakandla on 6/5/19.
//  Copyright © 2019 Pradeep Kodakandla. All rights reserved.
//

import XCTest
@testable import _0190524_PradeepKodakandla_NYCSchools
class SchoolsViewControllerTest: XCTestCase {
    var schoolsVC: SchoolsViewController?
    var tableView: UITableView!
    override func setUp() {
        let schoolVC = UIStoryboard.viewControllerFrom(storyboard: .main,
                                                       withIdentifier: .schoolController) as! SchoolsViewController
        
        schoolsVC = schoolVC
        schoolsVC?.loadViewIfNeeded()
        tableView = schoolsVC?.schoolsTableView
        schoolsVC?.viewModel?.dataSource = MockSchoolData.getMaockSchoolData()
        
        
    }
    
    func testNumOfSection() {
        let numOfSectionsForNum = schoolsVC?.schoolsTableView.numberOfSections
        XCTAssertNotNil(numOfSectionsForNum)
    }
    
    func testNumOfRowsInSection() {
        let numberOfRowsInSection = schoolsVC?.schoolsTableView.numberOfRows(inSection: 0)
        XCTAssertNotNil(numberOfRowsInSection)
    }
    
    func testCellForRowAtSectionZero() {
        let indexPath = IndexPath(row: 1, section: 0)
        let schoolTblCell = schoolsVC?.tableView(tableView,
                                                 cellForRowAt: indexPath) as? schoolTableViewCell
        XCTAssertEqual(schoolTblCell?.schoolNameLbl.text, "Clinton School Writers & Artists, M.S. 260")
        XCTAssertNotNil(schoolTblCell?.addressLbl.text)
    }
    
    
}
