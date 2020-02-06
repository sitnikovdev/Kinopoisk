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
    
// MARK: - UI Views
    // containers
    let viewContainer = BaseView(backgroundColor: #colorLiteral(red: 0.6117647059, green: 0.1529411765, blue: 0.6901960784, alpha: 1))
    let topContainer = BaseView(backgroundColor:#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
    let bottomContainer = BaseView(backgroundColor:#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
    let pictureContainer = BaseView(backgroundColor: #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.9529411765, alpha: 1))
    let descriptionContainer = BaseView(backgroundColor: #colorLiteral(red: 1, green: 0.5960784314, blue: 0, alpha: 1))
    // views
    let picture = BaseView(backgroundColor: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1))
    
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
        view.addSubview(viewContainer)
        pictureContainer.addSubview(picture)

    }
    
    fileprivate func addConstraints() {
        // topContainer
        viewContainer.edgesToSuperview(excluding: .bottom, insets: TinyEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),  usingSafeArea: true)
        topContainer.height(300)
        bottomContainer.height(500)
        
        pictureContainer.width(200)
        
        topContainer.stack([pictureContainer, descriptionContainer, UIView()], axis: .horizontal, width: nil, height: nil, spacing: 0)

        viewContainer.stack([topContainer,bottomContainer, UIView()], axis: .vertical,  width: nil, height: nil, spacing: 10)
//
 
        picture.edges(to: pictureContainer,  insets: TinyEdgeInsets(top: 16, left: 16, bottom: 16, right: 16),  isActive: true)
        
    }
    
    
    
    
}
