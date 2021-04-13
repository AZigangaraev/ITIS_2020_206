//
//  MockAuthorizationService.swift
//  Twitter
//
//  Created by Teacher on 16.02.2021.
//

import Foundation

class MockAuthorizationService: AuthorizationService {
    var currentUser: User? {
        get {
            let username = UserDefaults.standard.string(forKey: "user")
            return username.map { User(username: $0) }
        }
        set {
            if let user = newValue {
                UserDefaults.standard.set(user.username, forKey: "user")
            } else {
                UserDefaults.standard.removeObject(forKey: "user")
            }
        }
    }

    func authorize(username: String, password: String, completion: @escaping (Result<(), Error>) -> Void) {
        guard username == "admin" && password == "qwerty" else {
            return completion(.failure(AuthorizationError.wrongPassword))
        }

        currentUser = User(username: username)
        completion(.success(()))
    }

    func logOut() {
        currentUser = nil
    }
}
