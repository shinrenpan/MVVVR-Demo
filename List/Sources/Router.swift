//
//  Router.swift
//  List
//
//  Created by Joe Pan on 2025/3/6.
//

import Detail

@MainActor final class Router {
    weak var vc: ViewController?
}

// MARK: - Internal

extension Router {
    func showDetail(item: Item) {
        let to = Detail.ViewController(name: item.name, price: item.price)
        vc?.navigationController?.show(to, sender: nil)
    }
}
