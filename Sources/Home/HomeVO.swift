//
//  HomeVO.swift
//
//  Created by Shinren Pan on 2024/9/4.
//

import UIKit

final class HomeVO {
    let mainView = UIView(frame: .zero)
    let totalLabel = UILabel(frame: .zero)
    let infoButton = UIButton(configuration: makeButtonConfiguration())
    let list = UICollectionView(frame: .zero, collectionViewLayout: makeListLayout())
    lazy var dataSource = makeDataSource()

    init() {
        setupSelf()
        addViews()
    }
}

// MARK: - Public

extension HomeVO {
    func reloadList(response: HomeModel.DataLoadedResponse) {
        var snapshot = HomeModel.SnapShot()
        snapshot.appendSections([0])
        snapshot.appendItems(response.products, toSection: 0)
        dataSource.apply(snapshot)
    }
    
    func reloadSelectedUI(response: HomeModel.ProductSelectedResponse) {
        var snapshot = dataSource.snapshot()
        snapshot.reloadItems([response.product])

        dataSource.apply(snapshot) { [weak self] in
            guard let self else { return }
            totalLabel.text = "$" + response.total.formatted(.number)
        }
    }
}

// MARK: - Private

private extension HomeVO {
    func setupSelf() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.backgroundColor = .white

        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.textAlignment = .center
        totalLabel.text = "$0"

        list.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addViews() {
        let hStack = UIStackView(arrangedSubviews: [totalLabel, infoButton])
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.spacing = 8
        hStack.alignment = .center

        mainView.addSubview(hStack)
        mainView.addSubview(list)

        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            hStack.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),

            list.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 8),
            list.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            list.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            list.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
        ])
    }
    
    static func makeButtonConfiguration() -> UIButton.Configuration {
        var result = UIButton.Configuration.filled()
        result.image = .init(systemName: "info")

        return result
    }
    
    static func makeListLayout() -> UICollectionViewCompositionalLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.backgroundColor = .clear

        return .list(using: config)
    }
    
    func makeCell() -> HomeModel.CellRegistration {
        .init { cell, indexPath, itemIdentifier in
            var config = cell.defaultContentConfiguration()
            config.text = itemIdentifier.name
            config.secondaryText = itemIdentifier.price.formatted(.number)
            cell.accessories = [.checkmark(options: .init(isHidden: !itemIdentifier.selected))]
            cell.contentConfiguration = config
        }
    }
    
    func makeDataSource() -> HomeModel.DataSource {
        let cell = makeCell()

        return .init(collectionView: list) { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: cell, for: indexPath, item: itemIdentifier)
        }
    }
}
