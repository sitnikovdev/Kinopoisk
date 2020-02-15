//
//  BaseLabel.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 05.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import UIKit

class BaseTextLabel: UILabel {
    
    var leftContentOffset: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(backgroundColor: UIColor = .white, text: String = "", textColor: UIColor = .black, font: UIFont = .systemFont(ofSize: 10), cornerRadius: CGFloat = 6, borderWidth: CGFloat = 0, leftContentOffset: CGFloat = 0) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = UIColor.white.cgColor
        layer.masksToBounds = true
        numberOfLines = 0
        self.font = font
        adjustsFontForContentSizeCategory = true 
        self.text = text
        self.textColor = textColor
        self.leftContentOffset = leftContentOffset
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 0 + self.leftContentOffset, bottom: 0, right: 0)
              super.drawText(in: rect.inset(by: insets))
          }
}
