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
    var film: Film! {
        didSet {
            localLabel.text = "\(film.localizedName)"
            originalLabel.text = "\(film.name)"
            if let rating = film.rating {
                ratingLabel.text = "\(rating)"
            } else {
                ratingLabel.text = ""
            }
            if let rating: Double = film.rating {
                ratingLabel.textColor = Utils.setColorForRating(rating)
            }
        }
    }
    
    //    let films = FilmsData.films
    let labelHeight: CGFloat = 30
    
    static let reuseIdentifier = "FilmCell"
    static let sectionHeightSize: CGFloat = 60
    static let rowHeightSize: CGFloat = 150
    
    // MARK: - UI Views
    let viewContainer = BaseView(backgroundColor: #colorLiteral(red: 0.8117647059, green: 0.8862745098, blue: 0.9529411765, alpha: 1))
    
    let localLabel = BaseLabel(backgroundColor:#colorLiteral(red: 0.8117647059, green: 0.8862745098, blue: 0.9529411765, alpha: 1), text: "Бойцовский клуб",  borderWidth: 0)
    
    let ratingLabel = BaseLabel(backgroundColor: #colorLiteral(red: 0.8117647059, green: 0.8862745098, blue: 0.9529411765, alpha: 1), text: "8.934",  borderWidth: 0)
    let originalLabel = BaseLabel(backgroundColor: #colorLiteral(red: 0.8117647059, green: 0.8862745098, blue: 0.9529411765, alpha: 1), text: "Fight Club",  textColor: .systemGray, borderWidth: 0)
    
    
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
        contentView.addSubview(viewContainer)
        // local
        viewContainer.addSubview(localLabel)
        // rating
        viewContainer.addSubview(ratingLabel)
        // original
        viewContainer.addSubview(originalLabel)
    }
    
    fileprivate func constraintViews() {
        //container
        viewContainer.edges(to: contentView, insets: TinyEdgeInsets(top: 5, left: 16, bottom: 5, right: 16))
        
        // local
        
        localLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        localLabel.adjustsFontForContentSizeCategory = true
        //        localLabel.height(labelHeight)
        localLabel.width(250)
        localLabel.top(to: viewContainer, offset: 16, isActive: true)
        localLabel.bottomToTop(of: originalLabel, offset: -32, isActive: true)
        localLabel.leading(to: viewContainer, offset: 16, isActive: true)
        
        // rating
        ratingLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        ratingLabel.adjustsFontForContentSizeCategory = true
        
        ratingLabel.height(labelHeight)
        ratingLabel.trailing(to: viewContainer, offset: -16)
        ratingLabel.top(to: viewContainer, offset: 16)
        
        
        // original
        //        originalLabel.height(labelHeight)
        originalLabel.width(300)
        originalLabel.bottom(to: viewContainer, offset: -16,  isActive: true)
        originalLabel.leading(to: viewContainer, offset: 16, isActive: true)
    }
    
    
    
}
