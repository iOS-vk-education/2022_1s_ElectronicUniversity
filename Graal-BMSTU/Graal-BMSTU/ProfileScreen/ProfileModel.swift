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
    
    func authenticate(login: String, password: String) -> User?
    {
        let validTestUsersCredetials = [("Artem", "12345"), ("Maria", "54321"), ("Egor", "Bmstu")] // test data
        
        if let validCredetials = validTestUsersCredetials.first(where: {$0.0 == login && $0.1 == password})
        {
            AuthServiceMockup.loggedUser = User(name: validCredetials.0, familyName: "Tikhonenko")
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
