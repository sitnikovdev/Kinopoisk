//
//  ScrollViewController.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 06.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

// MARK: - Properties

    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 400)
    
// MARK: - Views
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .brown
        view.frame = self.view.bounds
        view.contentSize = self.contentViewSize
            
        return view
    }()
    
    
    lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.frame.size = self.contentViewSize
        
        return view
    }()
    
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Center of container view"
        
        return label
    }()
    
    

// MARK: - View Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupViews()
    }
    
// MARK: - Setup views
    
    fileprivate func setupViews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        containerView.addSubview(label)
        
        label.center(in: containerView)
    }
 
}
