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
    var films: [[Film]] = []
    var selectedFilm: Film!
    
    
// MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Films"
        setupTableView()
        loadData()
    }
    
    fileprivate func loadData() {
        
        films = FilmsData.getFilms()
        
//        print ("""
//               Films loaded: \(films.count)
//              """)
    }
    
    fileprivate func setupTableView() {

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = FilmCell.rowHeightSize
        
        tableView.register(FilmCell.self, forCellReuseIdentifier: FilmCell.reuseIdentifier)
    }

     
    
// MARK: - TableView delegate protocol implemetation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let filmDetailVc = FilmDetailViewController()
        navigationController?.pushViewController(filmDetailVc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return FilmCell.sectionHeightSize
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = BaseLabel(text: "Section: \(section)")
        
        if let film = films[section].first {
            header.text = film.year
        }
        
        
        let headerContainer = BaseView(backgroundColor: .white)
        
        let labelContainer = BaseView(backgroundColor: #colorLiteral(red: 0.2588235294, green: 0.2588235294, blue: 0.2588235294, alpha: 1))
        
        
        labelContainer.addSubview(header)
        headerContainer.addSubview(labelContainer)
        labelContainer.edges(to: headerContainer, insets: TinyEdgeInsets(top: 5, left: 16, bottom: 5, right: 16), isActive: true)
        header.height(25)
        header.width(100)
        header.center(in: labelContainer)
        return headerContainer
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return films.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return films[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilmCell.reuseIdentifier, for: indexPath) as? FilmCell
            else {
                fatalError("""
                    Expected \(FilmCell.self) type for reuseIdentifier \(FilmCell.reuseIdentifier).
                """
                )
        }
        
        
        cell.film = films[indexPath.section][indexPath.row]
        
        
        return cell
    }
    
    
    
    
}

