//
//  SchoolsAPI.swift
//  20190524-PradeepKodakandla-NYCSchools
//
//  Created by Pradeep Kodakandla on 5/27/19.
//  Copyright © 2019 Pradeep Kodakandla. All rights reserved.
//

import Foundation
import UIKit


class SchoolsAPI {
    private static let _defaultSession = URLSession(configuration: .default)
    private static var _dataTask: URLSessionDataTask?
    
    // Get All schools info from api call
    static func fetchAllSchools(completion: @escaping((Result<[School]>) -> Void)) {
        guard let schoolsUrl = URL(string: SchoolAPI.schoolsUrl) else {
            return
        }
        
        let request = URLRequest(url: schoolsUrl)
        
        _dataTask = _defaultSession.dataTask(with: request,
                                             completionHandler: { (data, response, error) in
                                                defer { self._dataTask = nil }
                                                let result = processSchoolsListRequest(data: data, error: error)
                                                OperationQueue.main.addOperation {
                                                    completion(result)
                                                }
        })
        _dataTask?.resume()
    }
    
    // Process all schools information from response
    static func processSchoolsListRequest( data: Data?,
                                           error: Swift.Error?) -> Result<[School]> {
        
        if let error = error {
            return .failure(Error.requestFailed(reason: error.localizedDescription))
        }
        
        guard let data = data else {
            return .failure(Error.noData)
        }
        let decoder = JSONDecoder()
        do {
            let schools = try decoder.decode([School].self, from: data)
            return .success(schools)
        } catch {
            return .failure(Error.jsonSerializationFailed(reason: "Failed to convert data to JSON"))
        }
        
    }
    
    // Get SAT results from api call by passing #DBN
    static func getSatResult(for dbn: String ,
                             completion: @escaping((Result<[SATResult]>) -> Void)) {
        let urlString = SchoolAPI.satResultUrl + dbn
        guard let satResultUrl = URL(string: urlString) else {
            return
        }
        print(satResultUrl)
        
        var request = URLRequest(url: satResultUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        _dataTask = _defaultSession.dataTask(with: request,
                                             completionHandler: { (data, response, error) in
                                                defer { self._dataTask = nil }
                                                let result = processSatResultRequest(data: data, error: error)
                                                OperationQueue.main.addOperation {
                                                    completion(result)
                                                }
        })
        _dataTask?.resume()
    }
    
    // Process SATResults from API response
    static func processSatResultRequest( data: Data?,
                                           error: Swift.Error?) -> Result<[SATResult]> {
        if let error = error {
            return .failure(Error.requestFailed(reason: error.localizedDescription))
        }
        guard let data = data else {
            return .failure(Error.noData)
        }
        let decoder = JSONDecoder()
        do {
            let user = try JSONSerialization.jsonObject(with: data, options: [])
            print(user)
        } catch {
            return .failure(Error.jsonSerializationFailed(reason: "Failed to convert data to JSON"))
        }
        do {
            let satResult = try decoder.decode([SATResult].self, from: data)
            return .success(satResult)
        } catch {
            return .failure(Error.jsonSerializationFailed(reason: "Failed to convert data to JSON"))
        }
    }
}

// MARK: - Error Definitions
extension SchoolsAPI {
    
    enum Error: Swift.Error {
        case noData
        case jsonSerializationFailed(reason: String)
        case requestFailed(reason: String)
    }
}

extension SchoolsAPI.Error: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .noData:
            return "No data returned with response"
        case .jsonSerializationFailed(let reason):
            return reason
        case .requestFailed(let reason):
            return reason
        }
    }
}

