import XCTest
@testable import Marvel

class MarvelDetailsPresenterTests: XCTestCase {
    let presenter = MarvelDetailPresenter()
    let mockView = MarvelDetailViewMock()

    lazy var dependencies: MarvelDetailDependencies = {
        return MarvelDetailDependencies(view: mockView, marvelId: 1)
    }()

    override func setUp() {
        super.setUp()
        presenter.setupDependencies(dependencies)
        mockView.presenter = presenter
    }

    func testViewLoaded() {
        let dummyModel = MarvelDetailModel.dummyModel()
        presenter.useCase = GetMarvelDetailsUseCaseMock(mockDetailsResponse: .success(dummyModel))
        presenter.viewLoaded()
        let viewModel = MarvelDetailViewModel(name: dummyModel.marvelName,
                                              description: dummyModel.marvelDescription,
                                              thumbnailURL: dummyModel.marvelURL)
        XCTAssertEqual(mockView.state, .render(viewModel: viewModel))
        XCTAssertEqual(viewModel.name, dummyModel.marvelName)
        XCTAssertEqual(viewModel.description, dummyModel.marvelDescription)
    }

    func testViewLoadedForFailure() {
        presenter.useCase = GetMarvelDetailsUseCaseMock(mockDetailsResponse: .failure(.apiError))
        presenter.viewLoaded()
        XCTAssertEqual(mockView.state, .error)
    }
}
