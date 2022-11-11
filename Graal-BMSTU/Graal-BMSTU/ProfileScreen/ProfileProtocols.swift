//
//  ProfileProtocols.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import Foundation


protocol ProfilePresenter
{
    
}

protocol ProfileRouter: AnyObject
{
    func continueWithAccount()
    func continueWithoutAccount()
    func switchToLogged()
    func switchToUnlogged()
}

