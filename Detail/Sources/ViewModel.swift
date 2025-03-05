//
//  ViewModel.swift
//  List
//
//  Created by Joe Pan on 2025/3/6.
//

import Foundation
import Observation

@Observable final class ViewModel {
    private(set) var state = State.none
    private let item: Item
    
    init(name: String, price: Decimal) {
        self.item = .init(name: name, price: price)
    }
}

// MARK: - Internal

extension ViewModel {
    func doAction(_ action: Action) {
        switch action {
        case .loadData:
            actionLoadData()
        }
    }
}

// MARK: - Private

private extension ViewModel {
    func actionLoadData() {
        let response = DataLoadResponse(item: item)
        state = .dataLoaded(response: response)
    }
}
