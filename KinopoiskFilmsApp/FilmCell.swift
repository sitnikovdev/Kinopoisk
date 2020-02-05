//
//  FilmCell.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 05.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import TinyConstraints

class FilmCell: UITableViewCell {
    
// MARK: - Properties
    
    let films = FilmsData.films
    
    static let reuseIdentifier = "FilmCell"
    static let sectionHeightSize: CGFloat = 50
    static let rowHeightSize: CGFloat = 150
    
// MARK: - UI Views
    let localName = TinyView(backgroundColor: #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.9529411765, alpha: 1))
    let rating = TinyView(backgroundColor: #colorLiteral(red: 0.2980392157, green: 0.6862745098, blue: 0.3137254902, alpha: 1))

// MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Views setup
    
    fileprivate func setupViews() {
        addViews()
        constraintViews()
    }

    fileprivate func addViews() {
        contentView.addSubview(localName)
        contentView.addSubview(rating)
    }
    
    fileprivate func constraintViews() {
        // local name
        localName.height(20)
        localName.width(100)
        localName.top(to: contentView, offset: 16, isActive: true)
        localName.leading(to: contentView, offset: 16, isActive: true)
        
        // rating
        rating.height(20)
        rating.width(50)
        rating.trailing(to: contentView, offset: -16)
        rating.top(to: contentView, offset: 16)
        
    }
    
    
    
}
