//
//  MainListViewController.swift
//  MovieList
//
//  Created by Chrystian Salgado on 26/01/26.
//

import UIKit
import SwiftUI

class MainListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    lazy var tableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let viewModel: MainListViewModelProtocol
    var values: [Movies] = []
    
    var favoriteMovies: [Movies] = []
    var favoriteRepository: FavoriteRepository
    
    weak var favoritesHostingController: UIViewController?
    
    // MARK: - Initialize
    init(viewModel: MainListViewModelProtocol, favoriteRepository: FavoriteRepository) {
        self.viewModel = viewModel
        self.favoriteRepository = favoriteRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View controller life cycle
    override func loadView() {
        super.loadView()
        view.backgroundColor = .brown
        title = "Movie list main"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(MovieUITableViewCell.self, forCellReuseIdentifier: "MovieCellView")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        Task {
            do {
                self.values = try await viewModel.loadData()
                tableView.reloadData()
            } catch {
                // apresentar um alerta de erro
            }
        }
    }

    // MARK: - Navigation bar button for search & favorites
    private func setupNavigationBar() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        let favoritesButton = UIBarButtonItem(image: UIImage(systemName: "heart"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(didTapFavorites))
        navigationItem.rightBarButtonItems = [searchButton, favoritesButton]
    }
    
    @objc private func didTapSearch() {
        let searchVC = UIHostingController(
            rootView: MovieSearchView(
                viewModel: .init(favoriteRepository: self.favoriteRepository),
                onSelect: { [weak self] movie in
                    guard let self = self else { return }
                    self.pushMovieDetailView(movie: movie)
                }
            )
        )
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc private func didTapFavorites() {
        let favoritesListView = FavoritesListView(
            favoriteRepository: self.favoriteRepository,
            onSelect: { [weak self] movie in
                guard let self = self else { return }
                pushMovieDetailView(movie: movie)
            },
            onClose: { [weak self] in
//                self?.favoritesHostingController?.dismiss(animated: true)
            }
        )
        let hostingController = UIHostingController(rootView: favoritesListView)
        self.navigationController?.pushViewController(hostingController, animated: true)
    }

    // MARK: - Table View Setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCellView", for: indexPath) as! MovieUITableViewCell
        cell.setup(movie: values[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = values[indexPath.row]
        pushMovieDetailView(movie: movie)
    }
}

private extension MainListViewController {
    
    private func pushMovieDetailView(movie: Movies) {
        let detailVC = UIHostingController(rootView: MovieDetailView(viewModel: .init(movie: movie, favoriteRepository: self.favoriteRepository)))
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
