//
//  ProfileBuilder.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit



final class ProfileBuilder
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
    
    
    static func assemble(context: ProfileContext) -> ProfileBuilder
    {
        let router = ProfileRouterImpl(window: context.window)
        let presenter = ProfilePresenterImpl(router: router)
        let vc = ProfileViewController(presenter: presenter)
        
        presenter.view = vc
        router.setViewController(viewController: vc)
        
        return ProfileBuilder(vc: vc, presenter: presenter, router: router)
    }
}

struct ProfileContext
{
    let window: UIWindow
}
