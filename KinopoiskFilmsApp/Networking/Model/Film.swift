//
//  Film.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 05.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import Foundation
import UIKit

struct Film: Decodable  {
    let id: Int = 0
    let localizedName: String
    let name: String
    let year: Int
    let rating: Double?
    let imageUrl: String? 
    let description: String?
    let genres: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case localizedName = "localized_name"
        case name
        case year
        case rating
        case imageUrl = "image_url"
        case description
        case genres
    }
}

extension Film {
    static func groupByYears(_ films: [Film]) -> [[Film]]{
        var grouped: [[Film]] = []
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
            grouped.append(orderByRating ?? [])
        }
        return grouped
    }
    
    func setColorForRating() -> UIColor {
        // Set colorized film rating
        var color: UIColor = #colorLiteral(red: 0, green: 0.4823529412, blue: 0, alpha: 1)
        if let rating = self.rating {
            switch rating {
            case    7...: // from 7 and higher - #007b00
                color = #colorLiteral(red: 0, green: 0.4823529412, blue: 0, alpha: 1)
            case 5...6: // from 5 to 6 inclusive - #5f5f5f
                color = #colorLiteral(red: 0.3725490196, green: 0.3725490196, blue: 0.3725490196, alpha: 1)
            case 0..<5: // below 5 - #ff0b0b
                color = #colorLiteral(red: 1, green: 0.0431372549, blue: 0.0431372549, alpha: 1)
            default:
                // From 6 to 7 - undefined, set default color
                color = #colorLiteral(red: 0.3999555707, green: 0.4000248015, blue: 0.1652560234, alpha: 1)
            }
        }
        return color
    }
}
