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
            localLabel.text = "\(film.localizedName) / \(film.year)"
            originalLabel.text = "\(film.name)"
            if let rating = film.rating {
              ratingLabel.text = "\(rating)"
            } else {
                ratingLabel.text = ""
            }
            setRating()
        }
    }
    
//    let films = FilmsData.films
    let labelHeight: CGFloat = 30
    
    static let reuseIdentifier = "FilmCell"
    static let sectionHeightSize: CGFloat = 50
    static let rowHeightSize: CGFloat = 150
    
// MARK: - UI Views
    let viewContainer = BaseView(backgroundColor: #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.9529411765, alpha: 1))
    
    let localLabel = BaseLabel(backgroundColor:#colorLiteral(red: 1, green: 0.5960784314, blue: 0, alpha: 1), text: "Бойцовский клуб")
    let ratingLabel = BaseLabel(backgroundColor: #colorLiteral(red: 0.2980392157, green: 0.6862745098, blue: 0.3137254902, alpha: 1), text: "8.934")
    let originalLabel = BaseLabel(backgroundColor: #colorLiteral(red: 0.9568627451, green: 0.262745098, blue: 0.2117647059, alpha: 1), text: "Fight Club", textColor: .white)
    

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
//        localLabel.height(labelHeight)
        localLabel.width(300)
        localLabel.top(to: viewContainer, offset: 16, isActive: true)
        localLabel.bottomToTop(of: originalLabel, offset: -32, isActive: true)
        localLabel.leading(to: viewContainer, offset: 16, isActive: true)
        
        // rating
        ratingLabel.height(labelHeight)
        ratingLabel.trailing(to: viewContainer, offset: -16)
        ratingLabel.top(to: viewContainer, offset: 16)
        
        
        // original
//        originalLabel.height(labelHeight)
        originalLabel.width(300)
//        originalLabel.topToBottom(of: localLabel, offset: 16, isActive: true)
        originalLabel.bottom(to: viewContainer, offset: -16,  isActive: true)
        originalLabel.leading(to: viewContainer, offset: 16, isActive: true)
    }
    
    fileprivate func setRating() {
        // Set colorized film rating
        if let rating: Double = film.rating {
        switch rating {
        case    7...: // from 7 and higher - #007b00
                ratingLabel.backgroundColor = #colorLiteral(red: 0, green: 0.4823529412, blue: 0, alpha: 1)
            case 5...6: // from 5 to 6 inclusive - #5f5f5f
                ratingLabel.backgroundColor = #colorLiteral(red: 0.3725490196, green: 0.3725490196, blue: 0.3725490196, alpha: 1)
            case 0..<5: // below 5 - #ff0b0b
                ratingLabel.backgroundColor = #colorLiteral(red: 1, green: 0.0431372549, blue: 0.0431372549, alpha: 1)
            default:
                // From 6 to 7 - undefined, set default color
                ratingLabel.backgroundColor = #colorLiteral(red: 0.3999555707, green: 0.4000248015, blue: 0.1652560234, alpha: 1)
            }
        }
    }
    
}
