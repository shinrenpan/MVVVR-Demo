//
//  ViewOutlet.swift
//  List
//
//  Created by Joe Pan on 2025/3/6.
//

import UIKit

@MainActor final class ViewOutlet {
    let mainView = UIView()
    let itemName = UILabel()
    let itemPrice = UILabel()
    
    init() {
        setup()
        addViews()
    }
}

// MARK: - Internal

extension ViewOutlet {
    func reloadUI(item: Item) {
        itemName.text = item.name
        itemPrice.text = item.price.formatted(.number)
    }
}

// MARK: - Private

private extension ViewOutlet {
    func setup() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        itemName.translatesAutoresizingMaskIntoConstraints = false
        itemPrice.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addViews() {
        let vStack = UIStackView(arrangedSubviews: [itemName, itemPrice])
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.alignment = .center
        
        mainView.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
        ])
    }
}
