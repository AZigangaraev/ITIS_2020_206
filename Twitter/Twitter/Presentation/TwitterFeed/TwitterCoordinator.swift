//
//  TwitterCoordinator.swift
//  Twitter
//
//  Created by Teacher on 16.02.2021.
//

import UIKit

class TwitterCoordinator {
    var onFinish: (() -> Void)?

    func startViewController() -> UIViewController {
        twitterController()
    }

    func show(post: Tweet, onTopOf viewController: UIViewController) {
        viewController.present(postController(post: post), animated: true)
    }

    private let storyboard = UIStoryboard(name: "Main", bundle: nil)

    private func twitterController() -> UIViewController {
        let viewController: TwitterViewController = storyboard.instantiateViewController(identifier: "TwitterViewController")
        let viewModel = TwitterViewModelImplementation()
        viewModel.onFinish = onFinish
        viewController.viewModel = viewModel
        return viewController
    }

    private func postController(post: Tweet) -> UIViewController {
        let controller: PostViewController = storyboard.instantiateViewController(identifier: "PostViewController")
        controller.loadViewIfNeeded()
        controller.usernameLabel.text = post.username
        controller.postTextLabel.text = post.text
        return controller
    }
}
