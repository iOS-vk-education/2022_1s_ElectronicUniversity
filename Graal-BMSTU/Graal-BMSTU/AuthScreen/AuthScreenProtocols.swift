//
//  AuthScreenProtocols.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import Foundation

protocol AuthPresenter
{
    func authenticate(login: String?, password: String?)
    func onViewDidLoad()
}

protocol AuthViewControllerPr: AnyObject
{
    func displaySuccessNotification()
    func displayErrorNotification()
}
