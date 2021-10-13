import XCTest
@testable import Marvel

final class MarvelDetailPresenterMock: MarvelDetailPresenterContract {
    var view: MarvelDetailViewContract?
    var marvelId: Int = 0
    var dependencies: MarvelDetailDependencies?
    private(set) var isDependenciesSet = false

    func setupDependencies(_ dependencies: MarvelDetailDependencies) {
        isDependenciesSet = true
        self.dependencies = dependencies
    }

    func viewLoaded() {
    }
}
