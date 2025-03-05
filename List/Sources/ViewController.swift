//
//  ViewController.swift
//  List
//
//  Created by Joe Pan on 2025/3/6.
//

import UIKit

public final class ViewController: UIViewController {
    private let vo = ViewOutlet()
    private let vm = ViewModel()
    private let router = Router()
    private var first = true
    private lazy var dataSourec = makeDataSource()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
        setupBinding()
        setupVO()
    }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        if first {
            first = false
            vm.doAction(.loadData)
        }
    }
}

// MARK: - Private

private extension ViewController {
    func setupSelf() {
        view.backgroundColor = .white
        router.vc = self
    }

    func setupBinding() {
        _ = withObservationTracking {
                    vm.state
        } onChange: { [weak self] in
            guard let self else { return }
            Task { @MainActor [weak self] in
                guard let self else { return }
                if viewIfLoaded?.window == nil { return }
                
                switch vm.state {
                case .none:
                    stateNone()
                case let .dataLoaded(response):
                    stateDataLoaded(response: response)
                }
                
                setupBinding()
            }
        }
    }
    
    func setupVO() {
        view.addSubview(vo.mainView)
        
        NSLayoutConstraint.activate([
            vo.mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vo.mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vo.mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vo.mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        vo.list.delegate = self
    }
    
    func stateNone() {}
    
    func stateDataLoaded(response: DataLoadResponse) {
        var snapshot = SnapShot()
        snapshot.appendSections([0])
        snapshot.appendItems(response.items, toSection: 0)
        dataSourec.apply(snapshot, animatingDifferences: true)
    }
    
    func makeCell() -> CellRegistration {
        .init { cell, indexPath, itemIdentifier in
            var content = cell.defaultContentConfiguration()
            content.text = itemIdentifier.name
            content.secondaryText = itemIdentifier.price.formatted(.number)
            cell.contentConfiguration = content
        }
    }
    
    func makeDataSource() -> DataSource {
        let cell = makeCell()
    
        return .init(collectionView: vo.list) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cell, for: indexPath, item: itemIdentifier)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let item = dataSourec.itemIdentifier(for: indexPath) else {
            return
        }
        
        router.showDetail(item: item)
    }
}
