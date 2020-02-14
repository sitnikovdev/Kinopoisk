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
    var filmsArray: [[Film]] = []
    var selectedFilm: Film!
    var isRefreshing = false
    
    
    let repository = Repository(apiClient: APIClient())
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        self.view.addSubview(spinner)
        spinner.centerInSuperview()
        
        return spinner
    }()
    
    lazy var refreshContol: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = .gray
        return control
    }()
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSpinner()
        setupNavigationBarLabels()
        setupRefreshControl()
        setupTableView()
        registerTableCells()
        loadFilms()
    }
    
    fileprivate func startSpinner() {
        spinner.startAnimating()
    }
    
    fileprivate func stopSpinner() {
        spinner.stopAnimating()
    }
    
    fileprivate func showAlert()  {
        let alertContoller = UIAlertController.alert(title: "Internet Connection Error", message: "Would you like to try again?") {
            self.loadFilms()
        }
        self.present(alertContoller, animated: true, completion: nil)
    }
    
    // MARK: - Network
    
    fileprivate func loadFilms() {
        if isRefreshing {
            filmsArray.removeAll()
        }
        repository.getFilms { (result) in
            switch result {
            case .success(let items):
                if let items = items["films"] {
                    self.filmsArray = self.groupByYears(items)
                    
                }
                
                DispatchQueue.main.async {
                    self.stopSpinner()
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print("\(self) retrive error on get films: \(error)")
                self.showAlert()
                self.stopSpinner()
                self.refreshControl?.endRefreshing()
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
    
    // MARK: - Table View Support
    
    fileprivate func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = FilmCell.rowHeightSize
        tableView.clipsToBounds = true
        tableView.isOpaque = true
    }
    
    fileprivate func setupNavigationBarLabels() {
        navigationItem.title = "Films"
    }
    
    fileprivate func registerTableCells() {
        tableView.register(FilmCell.self, forCellReuseIdentifier: FilmCell.reuseIdentifier)
    }
    
    // MARK: - Refresh control support
    
    fileprivate func setupRefreshControl() {
        extendedLayoutIncludesOpaqueBars = true
        refreshContol.addTarget(self, action: #selector(reloadFilms), for: .valueChanged)
        tableView.refreshControl = refreshContol
    }
    
    @objc fileprivate func reloadFilms() {
        isRefreshing = true
        loadFilms()
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let filmDetailVc = FilmDetailViewController()
        let filmSelected = filmsArray[indexPath.section][indexPath.row]
        tableView.deselectRow(at: indexPath, animated: false)
        filmDetailVc.film = filmSelected
        
        navigationController?.pushViewController(filmDetailVc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return FilmCell.sectionHeightSize
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = BaseLabel(text: "Section: \(section)")
        
        
        if !filmsArray.isEmpty {
            
            if let film = filmsArray[section].first {
                header.text = String(film.year)
                header.textAlignment = .center
            }
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
        return filmsArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmsArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilmCell.reuseIdentifier, for: indexPath) as? FilmCell 
            else {
                fatalError("""
                    Expected \(FilmCell.self) type for reuseIdentifier \(FilmCell.reuseIdentifier).
                    """
                )
        }
        
        cell.film = filmsArray[indexPath.section][indexPath.row]
        
        return cell
    }
}



