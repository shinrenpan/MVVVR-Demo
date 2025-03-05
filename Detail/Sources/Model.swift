//
//  Model.swift
//  List
//
//  Created by Joe Pan on 2025/3/6.
//

import Foundation
import UIKit

enum Action {
    case loadData
}

enum State {
    case none
    case dataLoaded(response: DataLoadResponse)
}

struct DataLoadResponse {
    let item: Item
}

struct Item {
    let name: String
    let price: Decimal
}
