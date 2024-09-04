//
//  HomeVM.swift
//
//  Created by Shinren Pan on 2024/9/4.
//

import Combine
import UIKit

final class HomeVM {
    @Published var state = HomeModel.State.none
}

// MARK: - Public

extension HomeVM {
    func doAction(_ action: HomeModel.Action) {
        switch action {
        case .loadData:
            actionLoadData()
        case let .selectProduct(request):
            actionSelectProduct(request: request)
        }
    }
}

// MARK: - Private

private extension HomeVM {
    func actionLoadData() {
        let response = HomeModel.DataLoadedResponse(products: makeDefaultProducts())
        state = .dataLoaded(response: response)
    }

    func actionSelectProduct(request: HomeModel.SelectProductRequest) {
        let product = request.product
        product.selected.toggle()

        let total = request.allProduct.filter { $0.selected }.reduce(Decimal(0)) { $0 + $1.price }
        let response = HomeModel.ProductSelectedResponse(product: product, total: total)
        state = .productSeleced(response: response)
    }

    func makeDefaultProducts() -> [HomeModel.Product] {
        return [
            .init(name: "iPhone 15", price: .init(29900)),
            .init(name: "iPhone 15 Plus", price: .init(32900)),
            .init(name: "iPhone 15 Pro", price: .init(36900)),
            .init(name: "iPhone 15 Pro Max", price: .init(44900)),
        ]
    }
}
