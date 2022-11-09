//
//  AuthModel.swift
//  Graal-BMSTU
//
//  Created by Артём on 09.11.2022.
//

import Foundation

struct User
{
    let name: String?
    let familyName: String?
    let group: String? = "IU7-35B"
}

class AuthService
{
    func authenticate(login: String, password: String, callback: (User?) -> Void)
    {
        let validTestUsersCredetials = [("Artem", "12345"), ("Maria", "54321"), ("Egor", "Bmstu")] // test data
        
        if let validCredetials = validTestUsersCredetials.first(where: {$0.0 == login && $0.1 == password})
        {
            callback(User(name: validCredetials.0, familyName: nil))
        }
        else
        {
            callback(nil)
        }
    }
}
