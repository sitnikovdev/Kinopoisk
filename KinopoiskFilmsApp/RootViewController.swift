//
//  RootViewController.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 05.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import TinyConstraints

class RootViewController: UITableViewController {

// MARK: - Properties
    let tableViewSectionHeadrHeight = 50
    
    
// MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Films"
        setupTableView()
        
    }
    
    fileprivate func setupTableView() {

        tableView.delegate = self
        tableView.dataSource = self

        tableView.rowHeight = FilmCell.rowHeightSize
        
        tableView.register(FilmCell.self, forCellReuseIdentifier: FilmCell.reuseIdentifier)
    }

     
    
// MARK: - TableView delegate protocol implemetation
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return CGFloat(self.tableViewSectionHeadrHeight)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let outerContainer = BaseView(backgroundColor: .white)
        
        let labelContainer = BaseView(backgroundColor: #colorLiteral(red: 0.2588235294, green: 0.2588235294, blue: 0.2588235294, alpha: 1))
        let header = BaseLabel(text: "Section: \(section)")
        labelContainer.addSubview(header)
        outerContainer.addSubview(labelContainer)
        labelContainer.edges(to: outerContainer, insets: TinyEdgeInsets(top: 5, left: 16, bottom: 5, right: 16), isActive: true)
        header.height(25)
        header.width(100)
        header.center(in: labelContainer)
        return outerContainer
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmCell.reuseIdentifier, for: indexPath)
        
        cell.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        
        return cell
    }
    
    
}

