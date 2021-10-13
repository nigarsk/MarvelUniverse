import XCTest
@testable import Marvel

class MarvelDetailBuilderTests: XCTestCase {
    let mockView = MarvelDetailViewMock()
    let mockPresenter = MarvelDetailPresenterMock()
    
    lazy var dependencies: MarvelDetailDependencies = {
        return MarvelDetailDependencies(view: mockView, marvelId: 1)
    }()

    func testBuild() {
        let view = MarvelDetailBuilder(view: mockView, presenter: mockPresenter).build(marvelId: 1)
        XCTAssert(view === mockView)
        XCTAssertTrue(mockPresenter.isDependenciesSet)
    }
}
