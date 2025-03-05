//
//  ViewModel.swift
//  List
//
//  Created by Joe Pan on 2025/3/6.
//

import Observation

@Observable final class ViewModel {
    private(set) var state = State.none
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
        let items: [Item] = [
            .init(name: "Apple Watch", price: .init(9.99)),
            .init(name: "iPhone", price: .init(99.99)),
            .init(name: "iPad", price: .init(999.99))
        ]
        
        let response = DataLoadResponse(items: items)
        state = .dataLoaded(response: response)
    }
}
