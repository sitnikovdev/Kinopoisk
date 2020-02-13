//
//  FilmServiceAPI.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 07.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import Foundation

class FilmServiceAPI {
    
// MARK: - Properties
    public static let shared = FilmServiceAPI()
    
    private init() {}
    private let urlSession = URLSession.shared
    
    private let baseURL = URL(string: "https://s3-eu-west-1.amazonaws.com/sequeniatesttask/films.json")
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return jsonDecoder
    }()
    
// MARK: - Base method
    
    private func fetchFilmData<T: Decodable>(url: URL, completion: @escaping (Result<[String: [T]], APIServiceError>) -> Void) {
        
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: url) { (result) in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode,  200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let values = try self.jsonDecoder.decode([String: [T]].self, from: data)
                    completion(.success(values))
                } catch (let error) {
                    completion(.failure(.apiError(error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(.apiError(error.localizedDescription)))
            }
        }.resume()
    }
    
    
   
    
// MARK: - Fetch films func
    
    public func fetchFilms(result: @escaping (Result<[String: [Film]], APIServiceError>) ->  Void) {
        
        fetchFilmData(url:  baseURL!, completion: result)
    
    }
    
   
 
    
// MARK: - API Error
    public enum APIServiceError: Error {
        case apiError(String)
        case invalidEndpoint
        case invalidResponse
        case noData
        case decodeError
    }
}
