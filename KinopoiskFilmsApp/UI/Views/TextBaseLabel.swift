//
//  TextBaseLabel.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 14.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import UIKit


class TextBaseLabel: UILabel {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(backgroundColor: UIColor = .white, text: String, textColor: UIColor = .black, font: UIFont = .systemFont(ofSize: 16), cornerRadius: CGFloat = 6, borderWidth: CGFloat = 2) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = UIColor.white.cgColor
        layer.masksToBounds = true
        numberOfLines = 0
        self.font = font
        self.text = text
        self.textColor = textColor

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     

    override func drawText(in rect: CGRect) {
           let insets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)//CGRect.inset(by:)
           super.drawText(in: rect.inset(by: insets))
       }
}
