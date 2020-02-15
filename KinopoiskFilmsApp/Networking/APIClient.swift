//
//  APIClient.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 14.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import Foundation

typealias responseAPIResult = Result<Data, Error>


final class APIClient {
    
    func load(_ resource: Resource, result: @escaping ((responseAPIResult) -> Void)) {
        let request = URLRequest(resource)
        let configuration = URLSessionConfiguration.default
//        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let filmSession = URLSession(configuration: configuration)
        
        let task = filmSession.dataTask(with: request) { (data, response, error) in
            guard let `data` = data else {
                result(.failure(APIClientError.noData))
                return
            }
            if let `error` = error {
                result(.failure(error))
                return
            }
            result(.success(data))
        }
        task.resume()
    }
    
    enum APIClientError: Error {
        case noData
    }
}
