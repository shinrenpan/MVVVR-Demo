//
//   HomeVO.swift Created by Shinren Pan on 2024/2/23.
//
//   Copyright (c) 2024 Shinren Pan All rights reserved.
//

import UIKit

final class HomeVO {
    let mainView = UIView(frame: .zero)
    let list = UITableView(frame: .zero, style: .plain)
    let messageLabel = UILabel(frame: .zero)
    
    init() {
        setupSelf()
        addViews()
    }
}

// MARK: - Public

extension HomeVO {
    func reloadData(_ mode: HomeModels.DisplayModel) {
        list.refreshControl?.endRefreshing()
        list.reloadData()
    }
    
    func reloadMessageUI(_ message: String) {
        list.refreshControl?.endRefreshing()
        messageLabel.text = message
        messageLabel.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.messageLabel.isHidden = true
        }
    }
}

// MARK: - Private

private extension HomeVO {
    func setupSelf() {
        mainView.backgroundColor = .white
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        list.translatesAutoresizingMaskIntoConstraints = false
        list.register(HomeItemCell.self, forCellReuseIdentifier: "\(HomeItemCell.self)")
        list.rowHeight = 60.0
        list.refreshControl = .init(frame: .zero)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.backgroundColor = .black
        messageLabel.textColor = .white
        messageLabel.font = .boldSystemFont(ofSize: 20)
        messageLabel.numberOfLines = 0
        messageLabel.isHidden = true
        messageLabel.clipsToBounds = true
        messageLabel.layer.cornerRadius = 4
        messageLabel.text = "Hello"
    }
    
    func addViews() {
        mainView.addSubview(list)
        NSLayoutConstraint.activate([
            list.topAnchor.constraint(equalTo: mainView.topAnchor),
            list.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            list.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            list.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
        ])
        
        mainView.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -36),
            messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: mainView.leadingAnchor, constant: 36),
            messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: mainView.trailingAnchor, constant: -36),
        ])
    }
}
