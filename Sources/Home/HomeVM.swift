//
//  HomeVM.swift Created by Shinren Pan on 2024/2/23.
//
//  Copyright (c) 2024 Shinren Pan All rights reserved.
//

import Combine
import UIKit

final class HomeVM {
    @Published private(set) var state = HomeModels.State.none
    private(set) var model = HomeModels.DisplayModel()
}

// MARK: - Public

extension HomeVM {
    func doAction(_ action: HomeModels.Action) {
        switch action {
        case .loadData:
            actionLoadData()
        }
    }
}

// MARK: - Private

private extension HomeVM {
    
    // MARK: Action
    
    func actionLoadData() {
        if model.isLoading { return }
        
        model.isLoading = true
        
        let testFailure = Bool.random()
        
        if testFailure {
            handleTestFailure()
            return
        }
        
        Task {
            do {
                let url = try makeURL()
                let session = URLSession.shared
                let result = try await session.data(from: url)
                try handleLoadData(result)
            }
            catch {
                handleLoadDataFailure(error)
            }
        }
    }
    
    // MARK: - Handle Something
    
    func handleLoadData(_ result: (Data, URLResponse)) throws {
        let items = try JSONDecoder().decode([HomeModels.Repository].self, from: result.0)
        model.items = items
        state = .dataLoaded
        model.isLoading = false
    }
    
    func handleLoadDataFailure(_ error: Error) {
        state = .failure(error)
        model.isLoading = false
    }
    
    func handleTestFailure() {
        state = .failure(NSError(domain: "", code: -999))
        model.isLoading = false
    }
    
    // MARK: - Make Something
    
    func makeURL() throws -> URL {
        let uri = "https://api.github.com/users/shinrenpan/repos"
        guard let url = URL(string: uri) else {
            throw HomeModels.APIError.invalidRUL
        }
        
        return url
    }
}
