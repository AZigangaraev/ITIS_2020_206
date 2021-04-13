//
//  AuthorizationViewController.swift
//  Twitter
//
//  Created by Teacher on 09.02.2021.
//

import UIKit

class AuthorizationViewController: UIViewController {
    @IBOutlet private var usernameField: UITextField!
    @IBOutlet private var passwordField: UITextField!

    var onFinish: (() -> Void)?

    private let authorizationService: AuthorizationService = MockAuthorizationService()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signInTap(_ sender: Any) {
        authorizationService.authorize(username: usernameField.text ?? "", password: passwordField.text ?? "") { result in
            switch result {
                case .success:
                    self.finish()
                case .failure(let error):
                    print("Could not authorize: \(error)")
            }
        }
    }

    private func finish() {
        onFinish?()
    }
}

