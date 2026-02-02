//
//  SceneDelegate.swift
//  MovieList
//
//  Created by Chrystian Salgado on 26/01/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _scene = (scene as? UIWindowScene) else { return }
        let _window = UIWindow(windowScene: _scene)
        let viewController = MainListViewController(
            viewModel: MainListViewModel()
        )
        _window.rootViewController = UINavigationController(rootViewController: viewController)
        _window.makeKeyAndVisible()
        self.window = _window
    }
}
