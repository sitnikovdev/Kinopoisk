//
//  Film.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 05.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import Foundation

struct Film: Decodable  {
    let id: Int = 0
    let localizedName: String
    let name: String
    let year: Int
    let rating: Double?
    let imageUrl: String? 
    let description: String?
    let genres: [String] = []
}
