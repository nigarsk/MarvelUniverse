import XCTest
@testable import Marvel

class MarvelListPresenterTests: XCTestCase {
    let presenter = MarvelListPresenter()
    let mockView = MarvelListViewMock()
    
    lazy var dependencies: MarvelListDependencies = {
        return MarvelListDependencies(view: mockView)
    }()

    override func setUp() {
        super.setUp()
        presenter.setupDependencies(dependencies)
        mockView.presenter = presenter
    }

    func testGetMarvelListApiSuccess() {
        setupDependencies()
        presenter.viewLoaded()
        XCTAssertEqual(mockView.state, .render)
    }

    func testLoadNext() {
        setupDependencies()
        presenter.viewLoaded()
        presenter.loadNext()
        XCTAssertEqual(mockView.state, .render)
    }

    func testGetMarvelListApiFailure() {
        presenter.useCase = GetMarvelListUseCaseMock(mockListResponse: .failure(.apiError))
        presenter.viewLoaded()
        XCTAssertEqual(mockView.state, .error)
    }

    func testNumberOfRows() {
        setupDependencies()
        presenter.viewLoaded()
        let result = presenter.numberOfRows(section: 0)
        XCTAssertEqual(result, 1)
    }

    func testViewModel() {
        setupDependencies()
        presenter.viewLoaded()
        let result = presenter.viewModel(indexPath: IndexPath(row: 0, section: 0)) as? MarvelListCellViewModel
        XCTAssertEqual(result?.name, "Doctor Stranger")
    }

    private func setupDependencies() {
        let dummyModel = MarvelListModel.dummyModel()
        presenter.useCase = GetMarvelListUseCaseMock(mockListResponse: .success(dummyModel))
    }
}
