//
//  HomeItemCell.swift Created by Shinren Pan on 2024/2/23.
//
//  Copyright (c) 2024 Shinren Pan All rights reserved.
//

import UIKit

final class HomeItemCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public

extension HomeItemCell {
    func reloadUI(_ repository: HomeModels.Repository) {
        textLabel?.text = repository.name
        detailTextLabel?.text = "Forks: \(repository.forks), Watchers: \(repository.watchers)"
    }
}
