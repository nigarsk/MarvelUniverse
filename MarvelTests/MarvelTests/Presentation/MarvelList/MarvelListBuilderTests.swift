import XCTest
@testable import Marvel

class MarvelListViewBuilderTests: XCTestCase {
    let mockView = MarvelListViewMock()
    let mockPresenter = MarvelListPresenterMock()

    lazy var dependencies: MarvelListDependencies = {
        return MarvelListDependencies(view: mockView)
    }()

    func testBuild() {
        let view = MarvelListViewBuilder(view: mockView, presenter: mockPresenter).build()
        XCTAssert(view === mockView)
        XCTAssertTrue(mockPresenter.isDependenciesSet)
    }
}
