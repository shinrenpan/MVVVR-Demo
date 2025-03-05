//
//  Model.swift
//  List
//
//  Created by Joe Pan on 2025/3/6.
//

import Foundation
import UIKit

typealias DataSource = UICollectionViewDiffableDataSource<Int, Item>
typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Item>
typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item>

enum Action {
    case loadData
}

enum State {
    case none
    case dataLoaded(response: DataLoadResponse)
}

struct DataLoadResponse {
    let items: [Item]
}

final class Item: NSObject, @unchecked Sendable {
    let name: String
    let price: Decimal
    var selected: Bool = false
    
    init(name: String, price: Decimal, selected: Bool = false) {
        self.name = name
        self.price = price
        self.selected = selected
    }
}
