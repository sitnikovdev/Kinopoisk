//
//  Repository.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 14.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import Foundation

typealias responseFilmsResult = Result<[String: [Film]], Error>

final class Repository {
    
    private let apiClient: APIClient!
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getFilms(_ completion: @escaping ((responseFilmsResult) -> Void)) {
        let resource = Resource(url:URL(string:"https://s3-eu-west-1.amazonaws.com/sequeniatesttask/films.json")!)
        apiClient.load(resource) { (result) in
            switch result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode([String: [Film]].self, from: data)
                    completion(.success(items))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
