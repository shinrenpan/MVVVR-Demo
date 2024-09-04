//
//  HomeModel.swift
//
//  Created by Shinren Pan on 2024/9/4.
//

import UIKit

enum HomeModel {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Product>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Product>
    typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Product>
}

// MARK: - Action / Request

extension HomeModel {
    enum Action {
        case loadData
        case selectProduct(request: SelectProductRequest)
    }

    struct SelectProductRequest {
        let product: Product
        let allProduct: [Product]
    }
}

// MARK: - State / Response

extension HomeModel {
    enum State {
        case none
        case dataLoaded(response: DataLoadedResponse)
        case productSeleced(response: ProductSelectedResponse)
    }

    struct DataLoadedResponse {
        let products: [Product]
    }

    struct ProductSelectedResponse {
        let product: Product
        let total: Decimal
    }
}

// MARK: - Models

extension HomeModel {
    final class Product: NSObject {
        let name: String
        let price: Decimal
        var selected: Bool = false

        init(name: String, price: Decimal) {
            self.name = name
            self.price = price
        }
    }
}
