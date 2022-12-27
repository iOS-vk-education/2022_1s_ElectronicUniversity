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
    func changeGroup(to: Group)
}

class AuthServiceMockup: AuthService {
    static let userVaultKey = "loggedUser"
    static private let validTestUsersCredentials = [("Artem", "12345"), ("Maria", "54321"),
                                                    ("Egor", "bmstu")] // test data

    func authenticate(login: String, password: String) -> User? {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()

        if let validCredentials = AuthServiceMockup.validTestUsersCredentials.first(where: { $0.0 == login && $0.1 == password }) {
            let user = User(name: validCredentials.0, familyName: "Tikhonenko", group: Group(dbPrimaryKey: 1, name: "ИУ7-35Б", stream:1))
            if let encoded = try? encoder.encode(user) {
                defaults.set(encoded, forKey: AuthServiceMockup.userVaultKey)
            }
            AppCoordinator.setNotFirstLaunch()
        } else {
            logout()
        }
        return getUserData()
    }

    func getUserData() -> User? {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        guard let savedPerson = defaults.object(forKey: AuthServiceMockup.userVaultKey) as? Data else { return nil }
        guard let user = try? decoder.decode(User.self, from: savedPerson) else { return nil }
        return user
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: AuthServiceMockup.userVaultKey)
        NotificationCenter.default.post(name: NSNotification.Name("selectedgroup.changeoccurred"), object: nil)
    }

    func changeGroup(to: Group) {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        let savedPersonData = defaults.object(forKey: AuthServiceMockup.userVaultKey) as? Data
        var user: User?
        if let savedPersonData = savedPersonData {
            guard let tmp = try? decoder.decode(User.self, from: savedPersonData) else { return }
            user = tmp
        } else {
            user = User(name: nil, familyName: nil, group:nil)
        }
        user?.group = to
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            defaults.set(encoded, forKey: AuthServiceMockup.userVaultKey)
        }
        AppCoordinator.setNotFirstLaunch()
    }
}
//let user = User(name: validCredentials.0, familyName: "Tikhonenko")
//UserDefaults.standard.set(user.name, forKey: AuthServiceMockup.userVaultKey + "name")
//UserDefaults.standard.set(user.familyName, forKey: AuthServiceMockup.userVaultKey +
//        "familyName")
//let group = user.group
//let groupUserKey = AuthServiceMockup.userVaultKey + "group"
//UserDefaults.standard.set(group?.name, forKey: groupUserKey + "name")
//UserDefaults.standard.set(group?.dbPrimaryKey, forKey: groupUserKey + "dbPrimaryKey")
//UserDefaults.standard.set(group?.stream, forKey: groupUserKey + "stream")