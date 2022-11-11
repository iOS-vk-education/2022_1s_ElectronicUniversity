//
//  ProfileViewController.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit


final class ProfileViewController: UIViewController
{
    private let presenter: ProfilePresenter
    
    init(presenter: ProfilePresenter)
    {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension ProfileViewController
{
    func setupUI()
    {
        
    }
}
