//
//  URLSession+.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 07.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import Foundation

extension URLSession {
    /// Handle data task with Result type
    func dataTask(with url: URL,   result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask
    {
        return dataTask(with: url) {(data, response, error) in
            if let error = error {
                result(.failure(error))
            }
            
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response,data)))
        }
    }
    
}
