//
//  Results.swift
//  20190524-PradeepKodakandla-NYCSchools
//
//  Created by Pradeep Kodakandla on 5/27/19.
//  Copyright © 2019 Pradeep Kodakandla. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
