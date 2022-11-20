//
//  ProfileModel.swift
//  Graal-BMSTU
//
//  Created by Артём on 09.11.2022.
//

import Foundation

struct User
{
    let name: String
    let familyName: String
    let group: String = "ИУ7-35Б"
}

class AuthServiceMockup: ProfileService
{
    static var loggedUser: User? = nil
    static let validTestUsersCredentials = [("Artem", "12345"), ("Maria", "54321"), ("Egor", "Bmstu")] // test data

    func authenticate(login: String, password: String) -> User?
    {

        if let validCredentials = AuthServiceMockup.validTestUsersCredentials.first(where: {$0.0 == login && $0.1 == password})
        {
            AuthServiceMockup.loggedUser = User(name: validCredentials.0, familyName: "Tikhonenko")
        }
        return AuthServiceMockup.loggedUser
    }
    
    func getUserData() -> User?
    {
        return AuthServiceMockup.loggedUser
    }
    
    func logout() {
        AuthServiceMockup.loggedUser = nil
    }
}
