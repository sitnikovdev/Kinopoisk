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
    let labelHeight: CGFloat = 30
    
    static let reuseIdentifier = "FilmCell"
    static let sectionHeightSize: CGFloat = 50
    static let rowHeightSize: CGFloat = 150
    
// MARK: - UI Views
    let container = BaseView(backgroundColor: #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.9529411765, alpha: 1))
    
    let local = BaseLabel(backgroundColor:#colorLiteral(red: 1, green: 0.5960784314, blue: 0, alpha: 1), text: "Бойцовский клуб")
    let rating = BaseLabel(backgroundColor: #colorLiteral(red: 0.2980392157, green: 0.6862745098, blue: 0.3137254902, alpha: 1), text: "8.934")
    let original = BaseLabel(backgroundColor: #colorLiteral(red: 0.9568627451, green: 0.262745098, blue: 0.2117647059, alpha: 1), text: "Fight Club", textColor: .white)
    

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
        contentView.addSubview(container)
        // local
        container.addSubview(local)
        // rating
        container.addSubview(rating)
        // original
        container.addSubview(original)
    }
    
    fileprivate func constraintViews() {
        //container
        container.edges(to: contentView, insets: TinyEdgeInsets(top: 5, left: 16, bottom: 5, right: 16))
        
        // local
        local.height(labelHeight)
        local.top(to: container, offset: 16, isActive: true)
        local.leading(to: container, offset: 16, isActive: true)
        
        // rating
        rating.height(labelHeight)
        rating.trailing(to: container, offset: -16)
        rating.top(to: container, offset: 16)
        
        // original
        original.height(labelHeight)
        original.width(100)
        original.bottom(to: container, offset: -16,  isActive: true)
        original.leading(to: container, offset: 16, isActive: true)
    }
    
    
    
}
