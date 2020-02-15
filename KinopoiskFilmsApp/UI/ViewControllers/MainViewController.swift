//
//  RootViewController.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 05.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import TinyConstraints

class MainViewController: UITableViewController {
    // MARK: - Properties
    let appTitle = "Фильмы"
    let repository = Repository(apiClient: APIClient())
    var filmsArray: [[Film]] = []
    let sectionHeaderSize:CGFloat = 60
    let estimatedRowHeight:CGFloat = 150
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        self.view.addSubview(spinner)
        spinner.centerInSuperview()
        return spinner
    }()
    
    var isRefreshing = false
    lazy var refreshContol: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = .gray
        return control
    }()
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startMonitor()
        startSpinner()
        setupNavigationBarLabels()
        setupRefreshControl()
        setupTableView()
        registerTableCells()
        loadFilms()
        
        NetStatus.shared.netStatusChangeHandler = {
            DispatchQueue.main.async {
                [ unowned self ] in
                sleep(1)
                if !NetStatus.shared.isConnected {
                    self.showAlert(error: APIClientError.noConnection)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Network
    fileprivate func startMonitor() {
        NetStatus.shared.startMonitoring()
    }
    
    fileprivate func loadFilms() {
        if isRefreshing {
            filmsArray.removeAll()
        }
        repository.getFilms { (result) in
            switch result {
            case .success(let items):
                if let items = items["films"] {
                    self.filmsArray = Film.groupByYears(items)
                }
                DispatchQueue.main.async {
                    self.updateUIOnFinishNetworkCall()
                }
            case .failure(let error):
                self.showAlert(error: error)
                self.updateUIOnFinishNetworkCall()
            }
        }
    }
    
    fileprivate func updateUIOnFinishNetworkCall() {
        self.tableView.reloadData()
        self.stopSpinner()
        self.refreshControl?.endRefreshing()
    }
    
    // MARK: - Table View Support
    
    fileprivate func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = self.estimatedRowHeight
        tableView.clipsToBounds = true
        tableView.isOpaque = true
    }
    
    fileprivate func setupNavigationBarLabels() {
        navigationItem.title = appTitle
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
        return self.sectionHeaderSize
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionLabel = BaseTextLabel(backgroundColor: #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1))
        sectionLabel.font = .preferredFont(forTextStyle: .title2)
        
        if let film = filmsArray[section].first {
            sectionLabel.text = String(film.year)
            sectionLabel.textAlignment = .center
        }
        let sectionView = BaseView()
        let sectionContainerView = BaseView(backgroundColor: #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1), borderWidth: 1)
        sectionContainerView.addSubview(sectionLabel)
        sectionView.addSubview(sectionContainerView)
        sectionContainerView.edges(to: sectionView, insets: TinyEdgeInsets(top: 5, left: 16, bottom: 5, right: 16), isActive: true)
        sectionLabel.center(in: sectionContainerView)
        return sectionView
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
    
    // MARK: - UI supports
    
    fileprivate func startSpinner() {
        spinner.startAnimating()
    }
    
    fileprivate func stopSpinner() {
        spinner.stopAnimating()
    }
    
    fileprivate func showAlert(error: Error)  {
        var message = ""
        switch error {
        case APIClientError.noConnection:
            message = "Интернет ресурс не доступен"
        default:
            message = "Ошибка подключения"
        }
        let alertContoller = UIAlertController.alert(title: "Ресурс не доступен", message: message)
        
        self.present(alertContoller, animated: true, completion: nil)
    }
}
