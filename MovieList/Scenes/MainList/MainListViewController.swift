//
//  MainListViewController.swift
//  MovieList
//
//  Created by Chrystian Salgado on 26/01/26.
//

import UIKit

class MainListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MainListViewModelDelegate {
    
    // MARK: - Properties
    lazy var titleLabel: UILabel = {
        let label: UILabel = .init()
        label.text = "Movie list main"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let viewModel: MainListViewModelProtocol
    var values: [Movies] = []
    
    // MARK: - Initialize
    init(viewModel: MainListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View controller life cycle
    override func loadView() {
        super.loadView()
        view.backgroundColor = .brown
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(MovieUITableViewCell.self, forCellReuseIdentifier: "MovieCellView")
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), // topo
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16), // esquerda
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16), // direita
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor), // esquerda sem espaçamento
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor), // direita sem espaçamento
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
    }

    // MARK: - Table View Setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCellView", for: indexPath) as! MovieUITableViewCell
        cell.setup(movieTitle: values[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        titleLabel.text = values[indexPath.row].title
    }
    
    // MARK: - MainListViewModelDelegate
    func displayData(values: [Movies]) {
        self.values = values
        tableView.reloadData()
    }
}
