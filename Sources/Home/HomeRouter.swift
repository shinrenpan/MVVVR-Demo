//
//  HomeRouter.swift Created by Shinren Pan on 2024/2/23.
//
//  Copyright (c) 2024 Shinren Pan All rights reserved.
//

import UIKit

final class HomeRouter {
    weak var vc: HomeVC?
}

// MARK: - Public

extension HomeRouter {
    func pushSomeVC() {
        let to = UIViewController()
        to.view.backgroundColor = .green
        to.title = "Pushed"
        vc?.navigationController?.pushViewController(to, animated: true)
    }
    
    func presentSomeVC() {
        let to = UIViewController()
        to.view.backgroundColor = .yellow
        vc?.present(to, animated: true)
    }
}
