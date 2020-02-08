//
//  FilmsData.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 05.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import Foundation

class FilmsData {
    //
    // MARK: - Properties and variable
    //
    var films = [[Film]]()
    
    //
    // MARK: - Initializers
    //
    init() {
        
        FilmServiceAPI.shared.fetchFilms { (result: Result<[String : [Film]], FilmServiceAPI.APIServiceError>) in
            switch result {
            case .success(let films):
                if let films  = films["films"] {
                    self.groupByYears(films)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
 
    //
    // MARK: - Private methods
    //
    fileprivate func groupByYears(_ films: [Film]) {
        let groupByYear: [Int : [Film]] = Dictionary(grouping: films) { $0.year }
        
        let sortedYears = groupByYear.keys.sorted()
        
        sortedYears.forEach {(key) in
            let films = groupByYear[key]
            let orderByRating = films?.sorted(by: { (lhs, rhs) -> Bool in
                if  let lhsRating = lhs.rating, let rhsRating = rhs.rating
                {
                    return rhsRating < lhsRating
                }
                return false
            })
            self.films.append(orderByRating ?? [])
        }
    }
    
    
}



