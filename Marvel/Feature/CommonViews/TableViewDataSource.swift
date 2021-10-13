import Foundation

protocol TableViewDataSource {
    func numberOfSections() -> Int
    func viewModel(indexPath: IndexPath) -> BaseViewModel?
    func numberOfRows(section: Int) -> Int
}

extension TableViewDataSource {
    func numberOfSections() -> Int {
        return 0
    }
}

protocol TableViewCellViewModel: Reusable {
    func setup(dataSource: TableViewDataSource, indexPath: IndexPath)
    func setup(viewModel: BaseViewModel)
}

extension TableViewCellViewModel {
    func setup(dataSource: TableViewDataSource, indexPath: IndexPath) {
        guard let viewModel = dataSource.viewModel(indexPath: indexPath) else {
            assertionFailure("CellViewModel missing for indexPath \(indexPath) in dataSource \(dataSource)")
            return
        }
        setup(viewModel: viewModel)
    }
}

