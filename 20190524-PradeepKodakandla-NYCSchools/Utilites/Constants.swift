//
//  Constants.swift
//  20190524-PradeepKodakandla-NYCSchools
//
//  Created by Pradeep Kodakandla on 5/27/19.
//  Copyright © 2019 Pradeep Kodakandla. All rights reserved.
//

import Foundation

struct SchoolAPI {
    static let schoolsUrl       = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    static let satResultUrl     = "https://data.cityofnewyork.us/resource/f9bf-2cp4?dbn="
}

// Storyboard name
enum Storyboard: String {
    case main                       = "Main"
}
// Storyboard viewController identifier
enum StoryboardID: String {
    case infoController          = "InfoViewController"
    case resultsVc               = "SATResultsViewController"

}

struct Email {
    static let errorAlertTitle           = "Unable To Send Email"
    static let errorMessage              = "Email is not set up on  your device. " +
    "Please check your device email configuration and try again."
}
struct xibAndIdentifers {
    static let overviewCell             = "OverviewTableViewCell"
    static let overviewXib              = "overview"
    static let contactCell              = "ContactTableViewCell"
    static let contactXib               = "contact"
    static let subwayCell               = "SubwayTableViewCell"
    static let subwayXib                = "subway"
    static let busCell                  = "BusTableViewCell"
    static let busXib                   = "bus"


}
