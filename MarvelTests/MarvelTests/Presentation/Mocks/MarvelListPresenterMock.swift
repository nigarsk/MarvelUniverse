import XCTest
@testable import Marvel

final class MarvelListPresenterMock: MarvelListPresenterContract {
    var view: MarvelListViewContract?
    var dependencies: MarvelListDependencies?
    private(set) var isDependenciesSet = false

    func setupDependencies(_ dependencies: MarvelListDependencies) {
        isDependenciesSet = true
        self.dependencies = dependencies
    }

    func viewLoaded() {
    }
    
    func didSelectedRowAt(indexPath: IndexPath) {
    }
    
    func loadNext() {
    }
    
    func viewModel(indexPath: IndexPath) -> BaseViewModel? {
        return nil
    }
    
    func numberOfRows(section: Int) -> Int {
        return 0
    }
}
