//
//  AuthorizationCoordinator.swift
//  Twitter
//
//  Created by Teacher on 16.02.2021.
//

import UIKit

class AuthorizationCoordinator {
    private var navigationController: UINavigationController?
    func startViewController() -> UIViewController {
        let navigationController = UINavigationController(rootViewController: authorizationController())
        self.navigationController = navigationController
        return navigationController
    }

    private let storyboard = UIStoryboard(name: "Main", bundle: nil)

    private func authorizationController() -> UIViewController {
        let viewController: AuthorizationViewController = storyboard.instantiateViewController(identifier: "AuthorizationViewController")
        viewController.onFinish = { [self] in
            let coordinator = TwitterCoordinator()
            coordinator.onFinish = {
                navigationController?.setViewControllers([ AuthorizationCoordinator().authorizationController() ], animated: false)
            }
            navigationController?.setViewControllers([ coordinator.startViewController() ], animated: true)
        }
        return viewController
    }

    private func phoneNumberController() -> UIViewController {
        let viewController: PhoneNumberController = storyboard.instantiateViewController(identifier: "PhoneNumberController")
        viewController.onFinish = { [weak viewController] phoneNumber in
            print("Entered number: \(phoneNumber)")
            viewController?.navigationController?.pushViewController(self.authorizationController(), animated: true)
        }
        return viewController
    }
}
