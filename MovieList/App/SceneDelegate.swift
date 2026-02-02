//
//  SceneDelegate.swift
//  MovieList
//
//  Created by Chrystian Salgado on 26/01/26.
//

import UIKit
import SwiftData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let container = try! ModelContainer(for: FavoriteMovie.self)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _scene = (scene as? UIWindowScene) else { return }
        let context = container.mainContext
        let favoriteRepository = FavoriteRepository(context: context)
        
        let _window = UIWindow(windowScene: _scene)
        let viewController = MainListViewController(
            viewModel: MainListViewModel(), favoriteRepository: favoriteRepository
        )
        let navController = UINavigationController(rootViewController: viewController)
        _window.rootViewController = navController
        _window.makeKeyAndVisible()
        self.window = _window
    }
}
