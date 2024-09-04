//
//  HomeRouter.swift
//
//  Created by Shinren Pan on 2024/9/4.
//

import UIKit
import SafariServices

final class HomeRouter {
    weak var vc: HomeVC?
}

// MARK: - Public

extension HomeRouter {
    func toAppleStore() {
        guard let urlComponents = URLComponents(string: "https://www.apple.com/store"),
              let url = urlComponents.url else {
            return
        }

        let to = SFSafariViewController(url: url)
        vc?.present(to, animated: true)
    }
}
