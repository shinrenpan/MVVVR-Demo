//
//  HomeVC.swift
//
//  Created by Shinren Pan on 2024/9/4.
//

import Combine
import UIKit

final class HomeVC: UIViewController {
    let vo = HomeVO()
    let vm = HomeVM()
    let router = HomeRouter()
    var binding: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
        setupBinding()
        setupVO()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if vo.dataSource.snapshot().itemIdentifiers.isEmpty {
            vm.doAction(.loadData)
        }
    }
}

// MARK: - Private

private extension HomeVC {
    // MARK: Setup Something

    func setupSelf() {
        view.backgroundColor = vo.mainView.backgroundColor
        router.vc = self
    }

    func setupBinding() {
        vm.$state.receive(on: DispatchQueue.main).sink { [weak self] state in
            guard let self else { return }
            if viewIfLoaded?.window == nil { return }

            switch state {
            case .none:
                stateNone()
            case let .dataLoaded(response):
                stateDataLoaded(response: response)
            case let .productSeleced(response):
                stateProductSeleced(response: response)
            }
        }.store(in: &binding)
    }

    func setupVO() {
        view.backgroundColor = vo.mainView.backgroundColor
        view.addSubview(vo.mainView)

        NSLayoutConstraint.activate([
            vo.mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vo.mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            vo.mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            vo.mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        vo.list.delegate = self

        vo.infoButton.addAction(.init() { [weak self] _ in
            guard let self else { return }
            router.toAppleStore()
        }, for: .touchUpInside)
    }

    // MARK: - Handle State

    func stateNone() {}

    func stateDataLoaded(response: HomeModel.DataLoadedResponse) {
        vo.reloadList(response: response)
    }

    func stateProductSeleced(response: HomeModel.ProductSelectedResponse) {
        vo.reloadSelectedUI(response: response)
    }
}

// MARK: - UICollectionViewDelegate

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let product = vo.dataSource.itemIdentifier(for: indexPath) else {
            return
        }

        let request = HomeModel.SelectProductRequest(
            product: product,
            allProduct: vo.dataSource.snapshot().itemIdentifiers
        )

        vm.doAction(.selectProduct(request: request))
    }
}
