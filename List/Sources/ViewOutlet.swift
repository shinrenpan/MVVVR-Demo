//
//  ViewOutlet.swift
//  List
//
//  Created by Joe Pan on 2025/3/6.
//

import UIKit

@MainActor final class ViewOutlet {
    let mainView = UIView()
    let list = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    init() {
        setup()
        addViews()
    }
}

// MARK: - Private

private extension ViewOutlet {
    func setup() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        list.translatesAutoresizingMaskIntoConstraints = false
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        list.collectionViewLayout = layout
    }
    
    func addViews() {
        mainView.addSubview(list)
        
        NSLayoutConstraint.activate([
            list.topAnchor.constraint(equalTo: mainView.topAnchor),
            list.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            list.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            list.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
    }
}
