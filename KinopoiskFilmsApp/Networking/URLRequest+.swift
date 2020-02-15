//
//  URLRequest+.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 14.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import Foundation

extension URLRequest {
    
    init(_ resource: Resource) {
        self.init(url: resource.url)
        self.httpMethod = resource.method
    }
}
