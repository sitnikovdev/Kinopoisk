//
//  FilmDetailViewController.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 05.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import TinyConstraints

class FilmDetailViewController: UIViewController {
    // MARK: - Properties
    var film: Film! {
        didSet {
            navigationItem.title = "\(film.localizedName)"
            originalLabel.text = "\(film.name)"
            yearLabel.text = "Год: \(film.year)"
            
            if let rating = film.rating {
                let textColor = Utils.setColorForRating(rating)
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
                  loadImageFrom(url: url)
                }
            }
            
        }
    }
    
    
    
    lazy var contentViewSize =  CGSize(width: self.view.frame.width, height: self.view.frame.height )
    // MARK: - UI Views
    // scroll view
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        
        return view
    }()
    
    // containers
    lazy var mainContainer: BaseView = {
        let view = BaseView(backgroundColor: .white, borderWidth: 0)
        view.frame.size = self.contentViewSize
        
        return view
    }()
    
    
    let topGroupContainer = BaseView(backgroundColor:.white, borderWidth: 0)
    let bottomContainer = BaseView(backgroundColor:.white, borderWidth: 0)
    let leftTopContainer = BaseView(backgroundColor: .white, borderWidth: 0)
    let rightTopContainer = BaseView(backgroundColor: .white, borderWidth: 0)
    // views
    let pictureImage = BaseImage(#imageLiteral(resourceName: "no_image.jpg"))

     let originalLabel = TextBaseLabel(backgroundColor: .white, text: "",
     textColor: .gray,
     font: .systemFont(ofSize: 15)
    )
 
    
    let yearLabel = BaseLabel(backgroundColor: .white, text: "Год: 1994", textColor: .black, font: .systemFont(ofSize: 22))
    let ratingTitle = BaseLabel(backgroundColor: .white, text: "Рейтинг: ", textColor: .black, font: .systemFont(ofSize: 22))
    let ratingLabel = BaseLabel(backgroundColor: .white, text: "Рейтинг: 8.233", textColor: .black, font: .systemFont(ofSize: 22))
    var descriptionLabel = TextBaseLabel(backgroundColor: .white, text: "",
                                     textColor: .black,
                                     font: .systemFont(ofSize: 22)
      )
    
    
    
    func loadImageFrom(url: URL) {
            DispatchQueue.global().async {
                [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.pictureImage.image = image
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.showAlert()
                    }
                }
            }
        }
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setupViews()
    }
    
    // MARK: - Views setup
    
    fileprivate func setupViews() {
        addViews()
        addConstraints()
    }
    
    fileprivate func addViews() {
        // viewContainer
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
        // topContainer
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
        
        
        // year
        yearLabel.height(25)
        yearLabel.left(to: rightTopContainer, offset: 8)
        yearLabel.topToBottom(of: originalLabel, offset: 10)
        
        // rating
        ratingLabel.height(25)
        ratingLabel.left(to: rightTopContainer, offset: 8)
        ratingLabel.topToBottom(of: yearLabel, offset: 10)
        
        descriptionLabel.topToBottom(of: topGroupContainer, offset: 16)
        descriptionLabel.left(to: mainContainer, offset: 15)
        descriptionLabel.right(to: mainContainer, offset: -15)
        descriptionLabel.bottom(to: mainContainer)
 
        
    }
    
    fileprivate func showAlert() {
        let alert = UIAlertController.alert(title: "Ресурс не найден", message: "Не возможно загрузить изображение", isCanceled: false, {
            self.pictureImage.image = #imageLiteral(resourceName: "no_image.jpg")
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

 
