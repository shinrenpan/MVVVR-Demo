//
//  HomeVC.swift Created by Shinren Pan on 2024/2/23.
//
//  Copyright (c) 2024 Shinren Pan All rights reserved.
//

import Combine
import UIKit

final class HomeVC: UIViewController {
    private let vo = HomeVO()
    private let vm = HomeVM()
    private let router = HomeRouter()
    private var binding: Set<AnyCancellable> = .init()
    private var firstLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
        setupBinding()
        setupVO()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        if !firstLoad { return }
        
        firstLoad = false
        doLoadData()
    }
}

// MARK: - Public

extension HomeVC {}

// MARK: - Private

private extension HomeVC {
    // MARK: Setup Something

    func setupSelf() {
        title = "Home"
        view.backgroundColor = vo.mainView.backgroundColor
        router.vc = self
    }

    func setupBinding() {
        vm.$state.receive(on: DispatchQueue.main).sink { [weak self] state in
            if self?.viewIfLoaded?.window == nil { return }

            switch state {
            case .none:
                self?.stateNone()
            case .dataLoaded:
                self?.stateDataLoaded()
            case let .failure(error):
                self?.stateFailure(error: error)
            }
        }.store(in: &binding)
    }

    func setupVO() {
        view.addSubview(vo.mainView)
        NSLayoutConstraint.activate([
            vo.mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vo.mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            vo.mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            vo.mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        vo.list.dataSource = self
        vo.list.delegate = self
        
        vo.list.refreshControl?.addTarget(self, action: #selector(doLoadData), for: .valueChanged)
    }

    // MARK: - Handle State

    func stateNone() {}
    
    func stateDataLoaded() {
        vo.reloadData(vm.model)
    }
    
    func stateFailure(error: Error) {
        vo.reloadMessageUI(error.localizedDescription)
    }
    
    // MARK: - Do Something
    
    @objc func doLoadData() {
        vm.doAction(.loadData)
    }
}

// MARK: - UITableViewDataSource

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(HomeItemCell.self)", for: indexPath) as! HomeItemCell
        let repository = vm.model.items[indexPath.row]
        cell.reloadUI(repository)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Bool.random() {
        case true:
            router.pushSomeVC()
        case false:
            router.presentSomeVC()
        }
    }
}
