//
//  infoViewModel.swift
//  20190524-PradeepKodakandla-NYCSchools
//
//  Created by Pradeep Kodakandla on 5/27/19.
//  Copyright © 2019 Pradeep Kodakandla. All rights reserved.
//

import Foundation
class infoViewModel {
    var resultData: SATResult?
    var selectedSchool: School?
    var selectedDbn: String {
        return selectedSchool?.dbn ?? ""
    }
    
    var numOfRows: Int {
        return 1
    }
    var numOfSections: Int {
        return 4
    }
    
    var subwayArray:[String] {
        return selectedSchool?.subway?.components(separatedBy: ",") ?? []
    }
    
    var busArray:[String] {
        return selectedSchool?.bus?.components(separatedBy: ",") ?? []
    }

    func getSatResults(for dbn: String,
                       completion: @escaping (Error?) -> Void) {
        print(dbn)
        SchoolsAPI.getSatResult(for: dbn, completion: { (result) in
            switch result {
            case .success(let satResult):
                self.resultData = satResult.first
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        })
    }
}
