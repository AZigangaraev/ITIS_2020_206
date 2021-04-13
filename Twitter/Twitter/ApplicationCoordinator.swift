//
//  ApplicationCoordinator.swift
//  Twitter
//
//  Created by Teacher on 13.04.2021.
//

import UIKit

class ApplicationCoordinator {
    static var shared = ApplicationCoordinator()
    var window: UIWindow?

    private let authorizationService: AuthorizationService = MockAuthorizationService()

    func startViewController(window: UIWindow) -> UIViewController {
        if authorizationService.currentUser != nil {
            let twitterCoordinator = TwitterCoordinator()
            twitterCoordinator.onFinish = {
                window.rootViewController = self.authorizationController()
            }
            return UINavigationController(rootViewController: twitterCoordinator.startViewController())
        } else {
            return authorizationController()
        }
    }

    private func showPost(id: String, window: UIWindow) {
        guard
            let rootController = window.rootViewController,
            let post = MockTwitterDataService().tweets.first(where: { $0.id == id })
        else { return }

        TwitterCoordinator().show(post: post, onTopOf: rootController)
    }

    func handlePushOpening(userInfo: [AnyHashable: Any]) {
        guard
            let deeplink: URL = userInfo["deeplink"]
                .flatMap({ $0 as? String })
                .flatMap({ URL(string: $0) }),
            let window = window
        else {
            return
        }

        processDeepLink(url: deeplink, window: window)
    }

    func processDeepLink(url: URL, window: UIWindow) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }

        let path = "/" + (components.host ?? "") + components.path
        switch path {
            case "/post":
                guard let id = components.queryItems?.first(where: { $0.name == "id" })?.value else { return }

                showPost(id: id, window: window)
            default:
                print("Unknown deeplink: \(url)")
        }
    }

    private func authorizationController() -> UIViewController {
        AuthorizationCoordinator().startViewController()
    }
}
