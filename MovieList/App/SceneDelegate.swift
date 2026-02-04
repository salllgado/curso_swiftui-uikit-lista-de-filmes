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
    var modelContainer: ModelContainer?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _scene = (scene as? UIWindowScene) else { return }
        let _window = UIWindow(windowScene: _scene)
        
        let favoriteRepository: FavoriteRepository? = try? getFavoriteRepository()
        let viewController = MainListViewController(
            viewModel: MainListViewModel(favoriteRepository: favoriteRepository)
        )
        _window.rootViewController = UINavigationController(rootViewController: viewController)
        _window.makeKeyAndVisible()
        self.window = _window
    }
    
    func getFavoriteRepository() throws -> FavoriteRepository? {
        do {
            let container = try ModelContainer(for: FavoriteMovie.self)
            self.modelContainer = container
            let context = container.mainContext
            return FavoriteRepository(context: context)
        } catch {
            return nil
        }
    }
}
