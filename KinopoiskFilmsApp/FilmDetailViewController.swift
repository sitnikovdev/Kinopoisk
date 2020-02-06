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
    lazy var contentViewSize =  CGSize(width: self.view.frame.width, height: self.view.frame.height + 400)
// MARK: - UI Views
    // scroll view
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.262745098, blue: 0.2117647059, alpha: 1)
        view.frame = self.view.bounds
        view.contentSize = self.contentViewSize
        return view
    }()
    
    // containers
    lazy var containerView: BaseView = {
        let view = BaseView(backgroundColor: #colorLiteral(red: 0.6117647059, green: 0.1529411765, blue: 0.6901960784, alpha: 1))
        view.frame.size = self.contentViewSize

        return view
    }()
    
    
    let topContainer = BaseView(backgroundColor:#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
    let textBottomContainer = BaseView(backgroundColor:#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
    let pictureContainer = BaseView(backgroundColor: #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.9529411765, alpha: 1))
    let descriptionContainer = BaseView(backgroundColor: #colorLiteral(red: 1, green: 0.5960784314, blue: 0, alpha: 1))
    // views
    let pictureImage = BaseImage(#imageLiteral(resourceName: "fight_club.jpg"))
    let originalLabel = BaseView(backgroundColor: #colorLiteral(red: 0.2588235294, green: 0.2588235294, blue: 0.2588235294, alpha: 1))
    let yearLabel = BaseLabel(backgroundColor: #colorLiteral(red: 0.6117647059, green: 0.1529411765, blue: 0.6901960784, alpha: 1), text: "1994", textColor: .black)
    let rating = BaseLabel(backgroundColor: #colorLiteral(red: 0.2980392157, green: 0.6862745098, blue: 0.3137254902, alpha: 1), text: "8.233", textColor: .white)
    let descriptionLabel = BaseLabel(backgroundColor: #colorLiteral(red: 0.2588235294, green: 0.2588235294, blue: 0.2588235294, alpha: 1), text: """
            Терзаемый хронической бессонницей и отчаянно пытающийся вырваться из мучительно скучной жизни, клерк встречает некоего Тайлера Дардена, харизматического торговца мылом с извращенной философией. Тайлер уверен, что самосовершенствование — удел слабых, а саморазрушение — единственное, ради чего стоит жить. Пройдет немного времени, и вот уже главные герои лупят друг друга почем зря на стоянке перед баром, и очищающий мордобой доставляет им высшее блаженство. Приобщая других мужчин к простым радостям физической жестокости, они основывают тайный Бойцовский Клуб, который имеет огромный успех. Но в концовке фильма всех ждет шокирующее открытие, которое может привести к непредсказуемым событиям…
           Пройдет немного времени, и вот уже главные герои лупят друг друга почем зря на стоянке перед баром, и очищающий мордобой доставляет им высшее блаженство. Приобщая других мужчин к простым радостям физической жестокости, они основывают тайный Бойцовский Клуб, который имеет огромный успех. Но в концовке фильма всех ждет шокирующее открытие, которое может привести к непредсказуемым событиям…
           Пройдет немного времени, и вот уже главные герои лупят друг друга почем зря на стоянке перед баром, и очищающий мордобой доставляет им высшее блаженство. Приобщая других мужчин к простым радостям физической жестокости, они основывают тайный Бойцовский Клуб, который имеет огромный успех. Но в концовке фильма всех ждет шокирующее открытие, которое может привести к непредсказуемым событиям…
           Пройдет немного времени, и вот уже главные герои лупят друг друга почем зря на стоянке перед баром, и очищающий мордобой доставляет им высшее блаженство. Приобщая других мужчин к простым радостям физической жестокости, они основывают тайный Бойцовский Клуб, который имеет огромный успех. Но в концовке фильма всех ждет шокирующее открытие, которое может привести к непредсказуемым событиям…
    """,
textColor: .white)
    
// MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Fight Club"
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
        
        scrollView.addSubview(containerView)
        
        containerView.addSubview(pictureContainer)
        pictureContainer.addSubview(pictureImage)
        
        containerView.addSubview(descriptionContainer)
        
        containerView.addSubview(originalLabel)

        descriptionContainer.addSubview(originalLabel)
        descriptionContainer.addSubview(yearLabel)
        descriptionContainer.addSubview(rating)
        
        textBottomContainer.addSubview(descriptionLabel)

    }
    
    fileprivate func addConstraints() {
        scrollView.edgesToSuperview(usingSafeArea: true)
        // topContainer
//        containerView.edgesToSuperview(excluding: .bottom, insets: TinyEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),  usingSafeArea: true)
        
        containerView.edges(to: scrollView, insets: TinyEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), isActive: true)
        
        topContainer.height(300)
//        topContainer.width(containerView.frame.width)
//        textBottomContainer.height(500)
        
        pictureContainer.width( containerView.frame.width / 2)
        descriptionContainer.width(containerView.frame.width / 2)
        
//        topContainer.top(to: containerView)
        
        topContainer.stack([pictureContainer, descriptionContainer, UIView()], axis: .horizontal, width: nil, height: nil, spacing: 0)

        containerView.stack([topContainer,textBottomContainer, UIView()], axis: .vertical,  width: nil, height: nil, spacing: 10)
 
        pictureImage.edges(to: pictureContainer,  insets: TinyEdgeInsets(top: 16, left: 16, bottom: 16, right: 16),  isActive: true)
        
        // original
        originalLabel.height(25)
        originalLabel.width(120)
        originalLabel.top(to: pictureImage, offset: 0)

        
        // year
        yearLabel.height(25)
        yearLabel.width(100)
        yearLabel.top(to: originalLabel, offset: 32)
        
        // rating
        rating.height(25)
        rating.width(120)
        rating.top(to: yearLabel, offset: 32)
        
        textBottomContainer.height(self.contentViewSize.height)
        textBottomContainer.width(self.view.frame.width)
        
        descriptionLabel.width(containerView.frame.width - 32)
        descriptionLabel.height(400)
        descriptionLabel.top(to: textBottomContainer, offset: 16)
        descriptionLabel.left(to: textBottomContainer, offset: 16)
        descriptionLabel.right(to: textBottomContainer, offset: -16)
//        descriptionLabel.c
//        descriptionLabel.left(to: textBottomContainer, offset: 16)
        // description
//         descriptionLabel.edges(to: textBottomContainer, insets: TinyEdgeInsets(top: 16, left: 16, bottom: 0, right: 16), isActive: true)

    }
    
    
    
    
}
