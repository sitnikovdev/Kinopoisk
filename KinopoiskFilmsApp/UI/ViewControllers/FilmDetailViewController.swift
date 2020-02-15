//
//  FilmDetailViewController.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 05.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import TinyConstraints

class FilmDetailViewController: UIViewController {
    // MARK: - Proprerties
    
    var film: Film! {
        didSet {
            navigationItem.title = "\(film.localizedName)"
            originalLabel.text = "\(film.name)"
            yearLabel.text = "Год: \(film.year)"
            
            if let rating = film.rating {
                let textColor = film.setColorForRating()
                let firstAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
                let secondAttributes = [NSAttributedString.Key.foregroundColor: textColor]
                let firstString = NSMutableAttributedString(string: "Рейтинг: ", attributes: firstAttributes)
                let secondString = NSAttributedString(string: String(rating), attributes: secondAttributes)
                
                firstString.append(secondString)
                ratingLabel.attributedText = firstString
            } else {
                ratingLabel.text = ""
            }
            if let description = film.description {
                descriptionLabel.text = description
            } else {
                descriptionLabel.text = ""
            }
            
            if let imageUrl = film.imageUrl {
                if let url = URL(string: imageUrl) {
                    ImageService.shared.getImage(withURL: url) { result in
                        switch result {
                        case .success(let image):
                            self.pictureImage.image = image
                        case .failure(let error):
                            self.showAlertWithError(error)
                            self.pictureImage.image = #imageLiteral(resourceName: "no_image.jpg")
                        }
                    }
                }
            }
        }
    }
    
    lazy var contentViewSize =  CGSize(width: self.view.frame.width, height: self.view.frame.height )
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        return view
    }()
    
    lazy var mainContainer: BaseView = {
        let view = BaseView()
        view.frame.size = self.contentViewSize
        return view
    }()
    
    let topGroupContainer = BaseView()
    let bottomContainer = BaseView()
    let leftTopContainer = BaseView()
    let rightTopContainer = BaseView()
    let pictureImage = BaseImage(#imageLiteral(resourceName: "no_image.jpg"))
    let originalLabel = BaseTextLabel(textColor: #colorLiteral(red: 0.4980392157, green: 0.5215686275, blue: 0.537254902, alpha: 1), leftContentOffset: 8)
    let yearLabel = BaseTextLabel()
    let ratingTitle = BaseTextLabel()
    let ratingLabel = BaseTextLabel()
    var descriptionLabel = BaseTextLabel(leftContentOffset: 8)
    
   
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Views setup
    
    fileprivate func setupViews() {
        addViews()
        addConstraints()
    }
    
    fileprivate func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainContainer)
        leftTopContainer.addSubview(pictureImage)
        rightTopContainer.addSubview(originalLabel)
        rightTopContainer.addSubview(yearLabel)
        rightTopContainer.addSubview(ratingLabel)
        mainContainer.addSubview(topGroupContainer)
        mainContainer.addSubview(descriptionLabel)
    }
    
    fileprivate func addConstraints() {
        scrollView.edgesToSuperview(usingSafeArea: true)
        mainContainer.edges(to: scrollView, insets: TinyEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), isActive: true)
        topGroupContainer.edges(to: mainContainer, excluding: .bottom, insets: TinyEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), isActive: true)
        topGroupContainer.stack([leftTopContainer, rightTopContainer], axis: .horizontal, width: mainContainer.frame.width / 2, height: nil,  spacing: 0)
        // picture
        pictureImage.edges(to: leftTopContainer,  insets: TinyEdgeInsets(top: 16, left: 16, bottom: 16, right: 16),  isActive: true)
        pictureImage.aspectRatio(2/3)
        // original
        originalLabel.top(to: rightTopContainer, offset: 20)
        originalLabel.left(to: rightTopContainer, offset: 0)
        originalLabel.right(to: rightTopContainer)
        originalLabel.font = .preferredFont(forTextStyle: .subheadline)
        // year
        yearLabel.left(to: rightTopContainer, offset: 8)
        yearLabel.topToBottom(of: originalLabel, offset: 10)
        yearLabel.font = .preferredFont(forTextStyle: .title3)
        // rating
        ratingLabel.left(to: rightTopContainer, offset: 8)
        ratingLabel.topToBottom(of: yearLabel, offset: 10)
        ratingLabel.font = .preferredFont(forTextStyle: .title3)
        descriptionLabel.topToBottom(of: topGroupContainer, offset: 0)
        descriptionLabel.left(to: mainContainer, offset: 16)
        descriptionLabel.right(to: mainContainer, offset: -16)
        descriptionLabel.bottom(to: mainContainer)
        descriptionLabel.font = .preferredFont(forTextStyle: .body)
    }
   
    // MARK: - Support methods
    
    fileprivate func showAlertWithError(_ error: Error) {
        let alert = UIAlertController.alert(title: "Ресурс не найден", message: "\(error.localizedDescription)")
        self.present(alert, animated: true, completion: nil)
    }
}
