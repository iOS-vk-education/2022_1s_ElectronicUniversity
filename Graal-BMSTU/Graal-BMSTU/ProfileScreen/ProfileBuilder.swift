//
//  ProfileBuilder.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit



final class ProfileBuilderImpl: ProfileBuilder
{
    let presenter: ProfilePresenter
    let vc: UIViewController
    private(set) weak var router: ProfileRouter!
    
    
    private init(vc: UIViewController, presenter: ProfilePresenter, router: ProfileRouter)
    {
        self.presenter = presenter
        self.vc = vc
        self.router = router
    }
    
    
    static func assemble(window: UIWindow) -> ProfileBuilder
    {
        let router = ProfileRouterImpl(window: window)
        let presenter = ProfilePresenterImpl(router: router, dataService: AuthServiceMockup())
        let vc = ProfileViewControllerImpl(presenter: presenter)
        
        presenter.view = vc
        router.setViewController(viewController: vc)
        
        return ProfileBuilderImpl(vc: vc, presenter: presenter, router: router)
    }
}

struct ProfileContext
{
    let window: UIWindow
}
