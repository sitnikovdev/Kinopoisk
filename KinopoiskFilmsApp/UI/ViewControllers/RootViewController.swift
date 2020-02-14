//
//  RootViewController.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 05.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import TinyConstraints

class RootViewController: UITableViewController {
    
    /// Films grouped by years
    var films: [[Film]] = []
    var selectedFilm: Film!
    
    let repository = Repository(apiClient: APIClient())
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
         loadData()
        setupTableView()
    
    }
    
    fileprivate func loadData() {
            repository.getFilms { (result) in
                switch result {
                case .success(let items):
                    if let items = items["films"] {
                        self.films = self.groupByYears(items)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    }
                case .failure(let error):
                    print("\(self) retrive error on get films: \(error)")
                }
            }
        }
    
    fileprivate func groupByYears(_ films: [Film]) -> [[Film]]{
        var grouped: [[Film]] = []
        let groupByYear: [Int : [Film]] = Dictionary(grouping: films) { $0.year }
        
        let sortedYears = groupByYear.keys.sorted()
        
        sortedYears.forEach {(key) in
            let films = groupByYear[key]
            let orderByRating = films?.sorted(by: { (lhs, rhs) -> Bool in
                if  let lhsRating = lhs.rating, let rhsRating = rhs.rating
                {
                    return rhsRating < lhsRating
                }
                return false
            })
            grouped.append(orderByRating ?? [])
        }
        return grouped
    }
    

    
    fileprivate func setupTableView() {
        navigationItem.title = "Films"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        //        tableView.rowHeight = FilmCell.rowHeightSize
        tableView.estimatedRowHeight = FilmCell.rowHeightSize
        tableView.clipsToBounds = true
        tableView.isOpaque = true
        
        
        tableView.register(FilmCell.self, forCellReuseIdentifier: FilmCell.reuseIdentifier)
    }
    
    
    // MARK: - TableView delegate protocol implemetation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let filmDetailVc = FilmDetailViewController()
        let filmSelected = films[indexPath.section][indexPath.row]
        tableView.deselectRow(at: indexPath, animated: false)
        filmDetailVc.film = filmSelected
        
        navigationController?.pushViewController(filmDetailVc, animated: true)
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return FilmCell.sectionHeightSize
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = BaseLabel(text: "Section: \(section)")
        
        if let film = films[section].first {
            header.text = String(film.year)
            header.textAlignment = .center
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



