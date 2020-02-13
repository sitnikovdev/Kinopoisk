//
//  BaseImage.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 06.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import UIKit

class BaseImage: UIImageView {
    var isLoaded = false
    
    init(_ image: UIImage, backgroundColor: UIColor = .purple,   cornerRadius: CGFloat = 0 ) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.isOpaque = true 
        
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
