//
//  FilmCell.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 05.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import TinyConstraints

class FilmCell: UITableViewCell {
    static let reuseIdentifier = "FilmCell"
    
    var film: Film! {
        didSet {
            localLabel.text = "\(film.localizedName)"
            originalLabel.text = "\(film.name)"
            if let rating = film.rating {
                ratingLabel.text = "\(rating)"
                ratingLabel.textColor = film.setColorForRating()
            } else {
                ratingLabel.text = ""
            }
        }
    }
    
    
    // MARK: - UI Views
    let viewContainer = BaseView(backgroundColor: #colorLiteral(red: 0.8117647059, green: 0.8862745098, blue: 0.9529411765, alpha: 1), borderWidth: 1)
    let localLabel = BaseTextLabel(backgroundColor:#colorLiteral(red: 0.8117647059, green: 0.8862745098, blue: 0.9529411765, alpha: 1))
    let ratingLabel = BaseTextLabel(backgroundColor: #colorLiteral(red: 0.8117647059, green: 0.8862745098, blue: 0.9529411765, alpha: 1))
    let originalLabel = BaseTextLabel(backgroundColor: #colorLiteral(red: 0.8117647059, green: 0.8862745098, blue: 0.9529411765, alpha: 1), textColor: #colorLiteral(red: 0.4980392157, green: 0.5215686275, blue: 0.537254902, alpha: 1))
    
    
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
        viewContainer.addSubview(localLabel)
        viewContainer.addSubview(ratingLabel)
        viewContainer.addSubview(originalLabel)
    }
    
    fileprivate func constraintViews() {
        //container
        viewContainer.edges(to: contentView, insets: TinyEdgeInsets(top: 5, left: 16, bottom: 5, right: 16))
        
        // local
        localLabel.width(250)
        localLabel.top(to: viewContainer, offset: 16, isActive: true)
        localLabel.bottomToTop(of: originalLabel, offset: -32, isActive: true)
        localLabel.leading(to: viewContainer, offset: 16, isActive: true)
        localLabel.font = .preferredFont(forTextStyle: .title2)
        
        // rating
        ratingLabel.trailing(to: viewContainer, offset: -16)
        ratingLabel.top(to: viewContainer, offset: 16)
        ratingLabel.font = .preferredFont(forTextStyle: .title2)
        
        // original
        originalLabel.width(300)
        originalLabel.bottom(to: viewContainer, offset: -16,  isActive: true)
        originalLabel.leading(to: viewContainer, offset: 16, isActive: true)
        originalLabel.font = .preferredFont(forTextStyle: .subheadline)
    }
}
