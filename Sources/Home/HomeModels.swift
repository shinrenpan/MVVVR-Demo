//
//  HomeModels.swift Created by Shinren Pan on 2024/2/23.
//
//  Copyright (c) 2024 Shinren Pan All rights reserved.
//

import UIKit

enum HomeModels {}

// MARK: - Action

extension HomeModels {
    enum Action {
        case loadData
    }
}

// MARK: - State

extension HomeModels {
    enum State {
        case none
        case dataLoaded
        case failure(Error)
    }
}

// MARK: - Other Model for DisplayModel

extension HomeModels {
    enum APIError: Error {
        case invalidRUL
        case apiFailure
    }
    
    struct Repository: Decodable {
        let name: String
        let url: String
        let forks: Int
        let watchers: Int
    }
}

// MARK: - Display Model for ViewModel

extension HomeModels {
    final class DisplayModel {
        var items: [Repository] = []
        var isLoading = false
    }
}
