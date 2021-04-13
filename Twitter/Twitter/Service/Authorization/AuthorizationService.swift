//
//  AuthorizationService.swift
//  Twitter
//
//  Created by Teacher on 09.02.2021.
//

import Foundation

enum AuthorizationError: Error {
    case wrongPassword
}

protocol AuthorizationService {
    var currentUser: User? { get }
    func authorize(username: String, password: String, completion: @escaping (Result<(), Error>) -> Void)
    func logOut()
}
