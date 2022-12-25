//
//  AuthService.swift
//  Graal-BMSTU
//
//  Created by Артём on 26.11.2022.
//

import Foundation

protocol AuthService {
    func authenticate(login: String, password: String) -> User?
    func getUserData() -> User?
    func logout()
}

class AuthServiceMockup: AuthService {
    static let userVaultKey = "loggedUser"
    static private let validTestUsersCredentials = [("Artem", "12345"), ("Maria", "54321"),
                                                    ("Egor", "bmstu")] // test data

    func authenticate(login: String, password: String) -> User? {
        if let validCredentials = AuthServiceMockup.validTestUsersCredentials.first(where: { $0.0 == login && $0.1 == password }) {
            UserDefaults.standard.set(User(name: validCredentials.0, familyName: "Tikhonenko"), forKey: AuthServiceMockup.userVaultKey)
            AppCoordinator.setNotFirstLaunch()
        } else {
            UserDefaults.standard.removeObject(forKey: AuthServiceMockup.userVaultKey)
        }
        return UserDefaults.standard.value(forKey: AuthServiceMockup.userVaultKey) as? User
    }

    func getUserData() -> User? {
        return UserDefaults.standard.value(forKey: AuthServiceMockup.userVaultKey) as? User
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: AuthServiceMockup.userVaultKey)
    }
}
